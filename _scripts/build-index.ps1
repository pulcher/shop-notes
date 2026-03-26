\shop-notes = Get-Location

function New-Index {
    param(
        [string]\,
        [string]\,
        [string]\
    )

    \ = Get-ChildItem -Path \ -Directory | Sort-Object Name -Descending
    if (-not \) { return }

    \ = @("# \", "")

    foreach (\ in \) {
        \ = Get-ChildItem -Path \.FullName -Filter \ -File -ErrorAction SilentlyContinue | Select-Object -First 1
        if (\) {
            \ = Resolve-Path -Path \.FullName -Relative
            \ += "- [\](\)"
        }
    }

    \ = Join-Path \ "_index.md"
    \ | Out-File \ -Encoding UTF8
    Write-Host "Updated index at \"
}

New-Index -Folder "resin/recipes" -Pattern "recipe.md" -Title "Resin Recipes"
New-Index -Folder "woodworking/projects" -Pattern "project.md" -Title "Woodworking Projects"
New-Index -Folder "woodworking/jigs" -Pattern "jig.md" -Title "Woodworking Jigs"
New-Index -Folder "woodworking/finishing/tests" -Pattern "test.md" -Title "Finishing Tests"
New-Index -Folder "electronics/builds" -Pattern "build.md" -Title "Electronics Builds"
