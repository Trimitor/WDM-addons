$CurrentPath = Get-Location
$OutputFolder = Join-Path -Path $CurrentPath -ChildPath ".archives"

if (-not (Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

$Folders = Get-ChildItem -Path $CurrentPath -Directory -Force |
    Where-Object {
        -not $_.Attributes.ToString().Contains("Hidden") -and
        -not $_.Name.StartsWith(".")
    }

foreach ($Folder in $Folders) {
    $ZipName = "$($Folder.Name).zip"
    $ZipPath = Join-Path -Path $OutputFolder -ChildPath $ZipName

    if (Test-Path $ZipPath) {
        Remove-Item $ZipPath -Force
    }

    Compress-Archive -Path $Folder.FullName -DestinationPath $ZipPath
}
