# SVL Wiki 同步脚本
# 将文档同步到多个 GitHub Wiki 仓库和 Gitee Wiki

param(
    [switch]$DryRun = $false,  # 仅预览，不实际推送
    [switch]$Force = $false,   # 强制覆盖远程内容
    [switch]$SkipGitee = $false # 跳过 Gitee 同步
)

# 配置
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir
$TempDir = Join-Path $env:TEMP "svl-wiki-sync-$(Get-Date -Format 'yyyyMMddHHmmss')"

# 目标 Wiki 仓库列表
$WikiRepos = @(
    @{
        Name = "SVL-Wiki"
        Url = "https://github.com/panda-lsy/SVL-Wiki.wiki.git"
    },
    @{
        Name = "SVL-StardewValleyLauncher"
        Url = "https://github.com/panda-lsy/SVL-StardewValleyLauncher.wiki.git"
    }
)

# Gitee Wiki 配置
$GiteeWiki = @{
    Name = "Gitee-SVL-StardewValleyLauncher"
    Url = "git@gitee.com:mc_shengxia/SVL-StardewValleyLauncher.wiki.git"
    RequiresSSH = $true
}

# 颜色输出函数
function Write-Info { Write-Host "[INFO] $args" -ForegroundColor Cyan }
function Write-Success { Write-Host "[OK] $args" -ForegroundColor Green }
function Write-Warning { Write-Host "[WARN] $args" -ForegroundColor Yellow }
function Write-Error { Write-Host "[ERROR] $args" -ForegroundColor Red }

# 检查 Git 是否可用
function Test-Git {
    try {
        $null = git --version
        return $true
    } catch {
        return $false
    }
}

# 扁平化文件名映射
function Get-FlatFileName {
    param([string]$RelativePath)
    
    # 标准化路径分隔符，移除 ./ 前缀和 .md 后缀
    $cleanPath = $RelativePath -replace '^\./', '' -replace '\.md$', '' -replace '\\', '/'
    
    # 如果是 docs/ 路径，转换为扁平名称
    if ($cleanPath -match '^docs/(.+)$') {
        return $Matches[1] -replace '/', '-'
    }
    
    return $cleanPath
}

# 更新 Markdown 文件中的链接
function Update-MarkdownLinks {
    param(
        [string]$FilePath,
        [hashtable]$FileMapping
    )
    
    $content = Get-Content $FilePath -Raw -Encoding UTF8
    $updated = $content
    
    # 更新所有相对路径链接
    foreach ($oldPath in $FileMapping.Keys) {
        $newPath = $FileMapping[$oldPath]
        
        # 匹配 Markdown 链接: [text](./path) 或 [text](path)
        $updated = $updated -replace "\[([^\]]+)\]\(\.?$oldPath\)", "[$1]($newPath)"
        $updated = $updated -replace "\[([^\]]+)\]\(\.?$oldPath\.md\)", "[$1]($newPath)"
    }
    
    # 保存更新后的内容
    Set-Content $FilePath -Value $updated -Encoding UTF8 -NoNewline
}

# 同步到单个 Wiki 仓库
function Sync-WikiRepo {
    param(
        [string]$Name,
        [string]$Url,
        [string]$TempPath
    )

    Write-Info "同步到 $Name Wiki..."
    
    $WikiDir = Join-Path $TempPath $Name
    
    try {
        # 克隆 Wiki 仓库
        Write-Info "  克隆 $Name Wiki..."
        git clone $Url $WikiDir 2>&1 | Out-Null
        
        if (-not (Test-Path $WikiDir)) {
            Write-Error "  克隆失败: $Name"
            return $false
        }
        
        # 清理旧文件（保留 .git）
        Get-ChildItem $WikiDir -Exclude ".git" | Remove-Item -Recurse -Force
        
        # 收集所有文件并创建映射
        Write-Info "  扫描文档..."
        $FileMapping = @{}
        $AllMdFiles = @()
        
        # 添加根目录 MD 文件
        Get-ChildItem "$RepoRoot\*.md" -File | ForEach-Object {
            $fileName = $_.Name
            if ($fileName -eq "README.md") {
                $FileMapping["./README"] = "Home"
                $FileMapping["README"] = "Home"
            } else {
                $baseName = $_.BaseName
                $FileMapping["./$baseName"] = $baseName
                $FileMapping[$baseName] = $baseName
            }
            $AllMdFiles += $_.FullName
        }
        
        # 添加 docs 目录下的所有 MD 文件
        Get-ChildItem "$RepoRoot\docs" -Filter "*.md" -Recurse -File | ForEach-Object {
            $relativePath = $_.FullName.Substring("$RepoRoot\".Length) -replace '\.md$', '' -replace '\\', '/'
            $flatName = Get-FlatFileName -RelativePath $relativePath
            
            # 添加多种链接格式到映射
            $FileMapping["./$relativePath"] = $flatName
            $FileMapping[$relativePath] = $flatName
            $FileMapping["./$relativePath.md"] = $flatName
            $FileMapping["$relativePath.md"] = $flatName
            
            $AllMdFiles += $_.FullName
        }
        
        Write-Info "  复制和扁平化文档..."
        
        # 复制并重命名所有文件
        foreach ($file in $AllMdFiles) {
            $relativePath = $file.Substring("$RepoRoot\".Length)
            $fileName = Split-Path $file -Leaf
            
            if ($fileName -eq "README.md") {
                $targetFile = Join-Path $WikiDir "Home.md"
            } elseif ($relativePath -match '^docs\\') {
                # 扁平化 docs 目录文件
                $flatName = Get-FlatFileName -RelativePath ($relativePath -replace '\.md$', '')
                $targetFile = Join-Path $WikiDir "$flatName.md"
            } else {
                $targetFile = Join-Path $WikiDir $fileName
            }
            
            Copy-Item $file $targetFile -Force
        }
        
        # 复制 images 文件夹
        if (Test-Path "$RepoRoot\images") {
            Copy-Item -Path "$RepoRoot\images" -Destination $WikiDir -Recurse -Force
        }
        
        # 更新所有 Markdown 文件中的链接
        Write-Info "  更新链接引用..."
        Get-ChildItem "$WikiDir\*.md" -File | ForEach-Object {
            Update-MarkdownLinks -FilePath $_.FullName -FileMapping $FileMapping
        }
        
        # 进入目录并提交
        Push-Location $WikiDir
        
        git add -A 2>&1 | Out-Null
        
        # 检查是否有更改
        $status = git status --porcelain
        if ([string]::IsNullOrEmpty($status)) {
            Write-Warning "  没有更改需要提交: $Name"
            Pop-Location
            return $true
        }
        
        if ($DryRun) {
            Write-Warning "  [DRY-RUN] 将提交以下更改:"
            git status --short
            Pop-Location
            return $true
        }
        
        # 提交
        $commitMsg = "docs: 同步文档 - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        git commit -m $commitMsg 2>&1 | Out-Null
        
        # 推送
        Write-Info "  推送到远程..."
        if ($Force) {
            git push -f origin master 2>&1 | Out-Null
        } else {
            git push origin master 2>&1 | Out-Null
        }
        
        Pop-Location
        
        Write-Success "  完成: $Name"
        return $true
        
    } catch {
        Write-Error "  同步失败: $Name - $_"
        return $false
    }
}

# 主函数
function Main {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host "  SVL Wiki 同步工具" -ForegroundColor Magenta
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host ""
    
    # 检查 Git
    if (-not (Test-Git)) {
        Write-Error "Git 未安装或不可用"
        exit 1
    }
    
    # 检查源文件
    if (-not (Test-Path "$RepoRoot\README.md")) {
        Write-Error "找不到源文档目录: $RepoRoot"
        exit 1
    }
    
    Write-Info "源目录: $RepoRoot"
    Write-Info "临时目录: $TempDir"
    
    if ($DryRun) {
        Write-Warning "DRY-RUN 模式: 不会实际推送更改"
    }
    
    # 创建临时目录
    New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
    
    $success = 0
    $failed = 0
    
    # 同步到每个 Wiki 仓库
    foreach ($repo in $WikiRepos) {
        $result = Sync-WikiRepo -Name $repo.Name -Url $repo.Url -TempPath $TempDir
        if ($result) {
            $success++
        } else {
            $failed++
        }
        Write-Host ""
    }
    
    # 同步到 Gitee Wiki
    if (-not $SkipGitee) {
        Write-Info "检查 Gitee SSH 配置..."
        
        # 检查 SSH 密钥
        $sshKeyPath = "$env:USERPROFILE\.ssh\id_ed25519"
        $sshPubKeyPath = "$env:USERPROFILE\.ssh\id_ed25519.pub"
        
        if (-not (Test-Path $sshKeyPath) -or -not (Test-Path $sshPubKeyPath)) {
            Write-Warning "未找到 SSH 密钥，跳过 Gitee 同步"
            Write-Host ""
            Write-Host "要启用 Gitee 同步，请按以下步骤操作：" -ForegroundColor Yellow
            Write-Host "1. 生成 SSH 密钥：" -ForegroundColor Yellow
            Write-Host "   ssh-keygen -t ed25519 -C `"你的邮箱@example.com`"" -ForegroundColor Cyan
            Write-Host "2. 将公钥添加到 Gitee：" -ForegroundColor Yellow
            Write-Host "   访问 https://gitee.com/profile/ssh_keys" -ForegroundColor Cyan
            Write-Host "   复制 $sshPubKeyPath 的内容" -ForegroundColor Cyan
            Write-Host "3. 测试连接：" -ForegroundColor Yellow
            Write-Host "   ssh -T git@gitee.com" -ForegroundColor Cyan
            Write-Host ""
        } else {
            Write-Success "找到 SSH 密钥"
            $result = Sync-WikiRepo -Name $GiteeWiki.Name -Url $GiteeWiki.Url -TempPath $TempDir
            if ($result) {
                $success++
            } else {
                $failed++
            }
            Write-Host ""
        }
    } else {
        Write-Info "已跳过 Gitee 同步"
    }
    
    # 清理临时目录
    Write-Info "清理临时文件..."
    try {
        Pop-Location 2>$null
        Remove-Item $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    } catch {
        Write-Warning "无法删除临时目录: $TempDir (可手动删除)"
    }
    
    # 输出结果
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host "  同步完成" -ForegroundColor Magenta
    Write-Host "  成功: $success | 失败: $failed" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Yellow" })
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host ""
    
    if ($failed -gt 0) {
        exit 1
    }
}

# 运行
Main
