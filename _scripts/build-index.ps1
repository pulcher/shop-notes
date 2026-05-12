$repoRoot = Get-Location

function Get-RelativeMarkdownPath {
    param(
        [string]$FromDirectory,
        [string]$ToPath
    )

    $fromUri = New-Object System.Uri((Resolve-Path -Path $FromDirectory).Path + [System.IO.Path]::DirectorySeparatorChar)
    $toUri = New-Object System.Uri((Resolve-Path -Path $ToPath).Path)
    $relative = $fromUri.MakeRelativeUri($toUri).ToString()
    return [System.Uri]::UnescapeDataString($relative)
}

function New-Index {
    param(
        [string]$Folder,
        [string]$Pattern,
        [string]$Title
    )

    if (-not (Test-Path -Path $Folder)) {
        Write-Host "Skipped missing folder: $Folder"
        return
    }

    $entries = Get-ChildItem -Path $Folder -Directory | Sort-Object Name -Descending
    if (-not $entries) {
        Write-Host "No entries found for $Folder"
        return
    }

    $lines = @("# $Title", "")
    $indexFile = Join-Path $Folder "_index.md"
    $indexDirectory = Split-Path -Path $indexFile -Parent

    foreach ($entry in $entries) {
        $targetFile = Get-ChildItem -Path $entry.FullName -Filter $Pattern -File -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($targetFile) {
            $relativePath = Get-RelativeMarkdownPath -FromDirectory $indexDirectory -ToPath $targetFile.FullName
            $lines += "- [$($entry.Name)]($relativePath)"
        }
    }

    $lines | Out-File $indexFile -Encoding UTF8
    Write-Host "Updated index at $indexFile"
}

New-Index -Folder "resin/recipes" -Pattern "recipe.md" -Title "Resin Recipes"
New-Index -Folder "resin/notes" -Pattern "note.md" -Title "Resin Notes"
New-Index -Folder "woodworking/projects" -Pattern "project.md" -Title "Woodworking Projects"
New-Index -Folder "woodworking/jigs" -Pattern "jig.md" -Title "Woodworking Jigs"
New-Index -Folder "woodworking/finishing" -Pattern "info.md" -Title "Finishing Notes"
New-Index -Folder "electronics/builds" -Pattern "build.md" -Title "Electronics Builds"
