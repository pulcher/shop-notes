param(
    [Parameter(Mandatory = \True)]
    [string]\
)

\ = \.ToLower().Replace(" ", "-")
\ = Get-Date -Format "yyyy-MM-dd"
\ = "electronics/builds/\-\"

New-Item -ItemType Directory -Path \ -Force | Out-Null
New-Item -ItemType Directory -Path "\/photos" -Force | Out-Null
New-Item -ItemType Directory -Path "\/wiring" -Force | Out-Null
New-Item -ItemType Directory -Path "\/firmware" -Force | Out-Null

\ = "_templates/electronics-build.md"
\ = Get-Content \ -Raw

\ = \.Replace("{{Name}}", \).
    Replace("{{Date}}", \).
    Replace("{{BuildId}}", [guid]::NewGuid().ToString())

\ | Out-File "\/build.md" -Encoding UTF8

Write-Host "Created electronics build at \"
code "\/build.md"
