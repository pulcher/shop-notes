param(
    [Parameter(Mandatory = \True)]
    [string]\
)

\ = \.ToLower().Replace(" ", "-")
\ = Get-Date -Format "yyyy-MM-dd"
\ = "woodworking/jigs/\-\"

New-Item -ItemType Directory -Path \ -Force | Out-Null
New-Item -ItemType Directory -Path "\/photos" -Force | Out-Null
New-Item -ItemType Directory -Path "\/sketches" -Force | Out-Null

\ = "\/measurements.json"
"{}" | Out-File \ -Encoding UTF8

\ = "_templates/woodworking-jig.md"
\ = Get-Content \ -Raw

\ = \.Replace("{{Name}}", \).
    Replace("{{Date}}", \).
    Replace("{{JigId}}", [guid]::NewGuid().ToString())

\ | Out-File "\/jig.md" -Encoding UTF8

Write-Host "Created jig at \"
code "\/jig.md"
