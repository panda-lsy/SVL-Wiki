# 测试扁平化逻辑

$RepoRoot = Split-Path -Parent $ScriptDir

# 扁平化文件名映射
function Get-FlatFileName {
    param([string]$RelativePath)
    
    # 移除 ./ 前缀和 .md 后缀
    $cleanPath = $RelativePath -replace '^\./', '' -replace '\.md$', ''
    
    # 如果是 docs/ 路径，转换为扁平名称
    if ($cleanPath -match '^docs/(.+)$') {
        return $Matches[1] -replace '/', '-'
    }
    
    return $cleanPath
}

# 测试文件名转换
Write-Host "`n=== File Flattening Test ===" -ForegroundColor Cyan

$testPaths = @(
    "docs/tutorials/Installation",
    "docs/features/Instance-Management",
    "docs/development/Project-Structure",
    "docs/CONTRIBUTING",
    "README",
    "./docs/tutorials/Getting-Started.md"
)

foreach ($path in $testPaths) {
    $flatName = Get-FlatFileName -RelativePath $path
    Write-Host "  $path -> $flatName" -ForegroundColor Green
}

Write-Host "`n=== 扫描实际文件 ===" -ForegroundColor Cyan

$FileMapping = @{}

# 添加根目录 MD 文件
Get-ChildItem "$RepoRoot\*.md" -File | ForEach-Object {
    $fileName = $_.Name
    if ($fileName -eq "README.md") {
        $FileMapping["./README"] = "Home"
        $FileMapping["README"] = "Home"
        Write-Host "  根目录: $fileName -> Home.md" -ForegroundColor Yellow
    } else {
        $baseName = $_.BaseName
        $FileMapping["./$baseName"] = $baseName
        $FileMapping[$baseName] = $baseName
        Write-Host "  根目录: $fileName -> $baseName.md" -ForegroundColor Yellow
    }
}

# 添加 docs 目录下的所有 MD 文件
Get-ChildItem "$RepoRoot\docs" -Filter "*.md" -Recurse -File | ForEach-Object {
    $relativePath = $_.FullName.Substring("$RepoRoot\".Length) -replace '\.md$', ''
    $flatName = Get-FlatFileName -RelativePath $relativePath
    
    # 添加多种链接格式到映射
    $FileMapping["./$relativePath"] = $flatName
    $FileMapping[$relativePath] = $flatName
    
    Write-Host "  docs: $relativePath -> $flatName.md" -ForegroundColor Green
}

Write-Host "`n=== 链接映射示例 ===" -ForegroundColor Cyan

$testLinks = @(
    "./docs/tutorials/Installation",
    "docs/features/Mod-Management",
    "./README"
)

foreach ($link in $testLinks) {
    if ($FileMapping.ContainsKey($link)) {
        Write-Host "  [$link] -> [$($FileMapping[$link])]" -ForegroundColor Green
    } else {
        Write-Host "  [$link] -> [未找到映射]" -ForegroundColor Red
    }
}

Write-Host "`n测试完成！" -ForegroundColor Cyan
