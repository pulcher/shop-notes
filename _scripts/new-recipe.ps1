param(
    [Parameter(Mandatory = \True)]
    [string]\
)

\ = \.ToLower().Replace(" ", "-")
\ = Get-Date -Format "yyyy-MM-dd"
\ = "resin/recipes/\-\"

New-Item -ItemType Directory -Path \ -Force | Out-Null
New-Item -ItemType Directory -Path "\/photos" -Force | Out-Null
New-Item -ItemType Directory -Path "\/sketches" -Force | Out-Null

\ = "_templates/resin-recipe.md"
\ = Get-Content \ -Raw

\ = \.Replace("{{Name}}", \).
    Replace("{{Date}}", \).
    Replace("{{BatchId}}", [guid]::NewGuid().ToString())

\ | Out-File "\/recipe.md" -Encoding UTF8

Write-Host "Created resin recipe at \"
code "\/recipe.md"
