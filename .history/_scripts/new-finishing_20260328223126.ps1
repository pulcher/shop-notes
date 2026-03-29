param(
    [Parameter(Mandatory = \True)]
    [string]\
)

\ = \.ToLower().Replace(" ", "-")
\ = Get-Date -Format "yyyy-MM-dd"
\ = "woodworking/finishing/\-\"

New-Item -ItemType Directory -Path \ -Force | Out-Null
New-Item -ItemType Directory -Path "\/photos" -Force | Out-Null
New-Item -ItemType Directory -Path "\/samples" -Force | Out-Null

\ = "_templates/woodworking-finishing-test.md"
\ = Get-Content \ -Raw

\ = \.Replace("{{Name}}", \).
    Replace("{{Date}}", \).
    Replace("{{TestId}}", [guid]::NewGuid().ToString())

\ | Out-File "\/in.md" -Encoding UTF8

Write-Host "Created finishing test at \"
code "\/test.md"
