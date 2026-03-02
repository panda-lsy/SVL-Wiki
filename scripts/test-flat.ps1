# Test flattening logic
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir

function Get-FlatFileName {
    param([string]$RelativePath)
    
    # Normalize path separators and remove ./ prefix and .md extension
    $cleanPath = $RelativePath -replace '^\./', '' -replace '\.md$', '' -replace '\\', '/'
    
    # If it's a docs/ path, convert to flat name
    if ($cleanPath -match '^docs/(.+)$') {
        return $Matches[1] -replace '/', '-'
    }
    
    return $cleanPath
}

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

Write-Host "`n=== Scan Actual Files ===" -ForegroundColor Cyan

$FileMapping = @{}

Get-ChildItem "$RepoRoot\*.md" -File | ForEach-Object {
    $fileName = $_.Name
    if ($fileName -eq "README.md") {
        $FileMapping["./README"] = "Home"
        $FileMapping["README"] = "Home"
        Write-Host "  Root: $fileName -> Home.md" -ForegroundColor Yellow
    } else {
        $baseName = $_.BaseName
        $FileMapping["./$baseName"] = $baseName
        $FileMapping[$baseName] = $baseName
        Write-Host "  Root: $fileName -> $baseName.md" -ForegroundColor Yellow
    }
}

Get-ChildItem "$RepoRoot\docs" -Filter "*.md" -Recurse -File | ForEach-Object {
    $relativePath = $_.FullName.Substring("$RepoRoot\".Length) -replace '\.md$', '' -replace '\\', '/'
    $flatName = Get-FlatFileName -RelativePath $relativePath
    
    # Add multiple link formats to mapping
    $FileMapping["./$relativePath"] = $flatName
    $FileMapping[$relativePath] = $flatName
    
    Write-Host "  Docs: $relativePath -> $flatName.md" -ForegroundColor Green
}

Write-Host "`n=== Link Mapping Examples ===" -ForegroundColor Cyan

$testLinks = @(
    "./docs/tutorials/Installation",
    "docs/features/Mod-Management",
    "./README"
)

foreach ($link in $testLinks) {
    if ($FileMapping.ContainsKey($link)) {
        Write-Host "  [$link] -> [$($FileMapping[$link])]" -ForegroundColor Green
    } else {
        Write-Host "  [$link] -> [NOT FOUND]" -ForegroundColor Red
    }
}

Write-Host "`nTest completed!" -ForegroundColor Cyan
