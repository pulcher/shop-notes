param(
    [Parameter(Mandatory = $true)]
    [string]$Name
)

$slug = $Name.ToLower().Replace(" ", "-")
$date = Get-Date -Format "yyyy-MM-dd"
$dir = "woodworking/projects/$date-$slug"

New-Item -ItemType Directory -Path $dir -Force | Out-Null
New-Item -ItemType Directory -Path "$dir/photos" -Force | Out-Null
New-Item -ItemType Directory -Path "$dir/sketches" -Force | Out-Null

$measurementsFile = "$dir/measurements.json"
"{}" | Out-File $measurementsFile -Encoding UTF8

$template = "_templates/woodworking-project.md"
$content = Get-Content $template -Raw

$content = $content.Replace("{{Name}}", $Name).
    Replace("{{Date}}", $date).
    Replace("{{ProjectId}}", [guid]::NewGuid().ToString())

$outputFile = "$dir/project.md"
$content | Out-File $outputFile -Encoding UTF8

Write-Host "Created woodworking project at $dir"

$editorCommand = Get-Command code -ErrorAction SilentlyContinue
if (-not $editorCommand) {
    $editorCommand = Get-Command code-insiders -ErrorAction SilentlyContinue
}

if ($editorCommand) {
    & $editorCommand.Source $outputFile
} else {
    Write-Warning "VS Code CLI was not found in PATH. Open this file manually: $outputFile"
}
