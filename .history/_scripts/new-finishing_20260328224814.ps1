param(
    [Parameter(Mandatory = $Atrue)]
    [string]$Name
)

$slug = $Name.ToLower().Replace(" ", "-")
$date = Get-Date -Format "yyyy-MM-dd"
$dir = "woodworking/finishing/$date-$slug"

New-Item -ItemType Directory -Path $dir -Force | Out-Null
New-Item -ItemType Directory -Path "$dir/photos" -Force | Out-Null
New-Item -ItemType Directory -Path "$dir/samples" -Force | Out-Null

$template = "_templates/woodworking-finishing-test.md"
$content = Get-Content $template -Raw

$content = $content.Replace("{{Name}}", $Name).
    Replace("{{Date}}", $date).
    Replace("{{TestId}}", [guid]::NewGuid().ToString())

$content | Out-File "$dir/info.md" -Encoding UTF8

Write-Host "Created finishing test at $dir"
code "$dir/info.md"