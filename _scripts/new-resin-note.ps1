param(
    [Parameter(Mandatory = $true)]
    [string]$Name
)

$slug = $Name.ToLower().Replace(" ", "-")
$date = Get-Date -Format "yyyy-MM-dd"
$dir = "resin/notes/$date-$slug"

New-Item -ItemType Directory -Path $dir -Force | Out-Null

$template = "_templates/resin-note.md"
$content = Get-Content $template -Raw

$content = $content.Replace("{{Name}}", $Name).
    Replace("{{Date}}", $date).
    Replace("{{NoteId}}", [guid]::NewGuid().ToString())

$outputFile = "$dir/note.md"
$content | Out-File $outputFile -Encoding UTF8

Write-Host "Created resin note at $dir"

$editorCommand = Get-Command code -ErrorAction SilentlyContinue
if (-not $editorCommand) {
    $editorCommand = Get-Command code-insiders -ErrorAction SilentlyContinue
}

if ($editorCommand) {
    & $editorCommand.Source $outputFile
} else {
    Write-Warning "VS Code CLI was not found in PATH. Open this file manually: $outputFile"
}
