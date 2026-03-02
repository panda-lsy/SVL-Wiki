# SVL Wiki 同步脚本
# 将文档同步到多个 GitHub Wiki 仓库

param(
    [switch]$DryRun = $false,  # 仅预览，不实际推送
    [switch]$Force = $false    # 强制覆盖远程内容
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
        
        # 复制文档文件
        Write-Info "  复制文档..."
        
        # 复制根目录 .md 文件
        Copy-Item -Path "$RepoRoot\*.md" -Destination $WikiDir -Force
        
        # 复制 docs 文件夹
        if (Test-Path "$RepoRoot\docs") {
            Copy-Item -Path "$RepoRoot\docs" -Destination $WikiDir -Recurse -Force
        }
        
        # 复制 images 文件夹
        if (Test-Path "$RepoRoot\images") {
            Copy-Item -Path "$RepoRoot\images" -Destination $WikiDir -Recurse -Force
        }
        
        # 设置 Home.md（GitHub Wiki 首页必须是 Home.md）
        if (Test-Path "$WikiDir\README.md") {
            Rename-Item "$WikiDir\README.md" "Home.md" -Force
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
