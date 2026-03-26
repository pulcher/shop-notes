param(
    [Parameter(Mandatory = \True)]
    [string]\
)

\ = \.ToLower().Replace(" ", "-")
\ = Get-Date -Format "yyyy-MM-dd"
\ = "woodworking/projects/\-\"

New-Item -ItemType Directory -Path \ -Force | Out-Null
New-Item -ItemType Directory -Path "\/photos" -Force | Out-Null
New-Item -ItemType Directory -Path "\/sketches" -Force | Out-Null

\ = "\/measurements.json"
"{}" | Out-File \ -Encoding UTF8

\ = "_templates/woodworking-project.md"
\ = Get-Content \ -Raw

\ = \.Replace("{{Name}}", \).
    Replace("{{Date}}", \).
    Replace("{{ProjectId}}", [guid]::NewGuid().ToString())

\ | Out-File "\/project.md" -Encoding UTF8

Write-Host "Created woodworking project at \"
code "\/project.md"
