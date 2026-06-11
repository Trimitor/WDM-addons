Add-Type -AssemblyName "System.IO.Compression"
Add-Type -AssemblyName "System.IO.Compression.FileSystem"

$CurrentPath = (Get-Location).Path
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

    $ZipStream = [System.IO.File]::Open($ZipPath, [System.IO.FileMode]::Create)
    $Archive = New-Object System.IO.Compression.ZipArchive($ZipStream, [System.IO.Compression.ZipArchiveMode]::Create)

    try {
        $Files = Get-ChildItem -Path $Folder.FullName -Recurse -File

        foreach ($File in $Files) {
            $RelativePath = $File.FullName.Substring($CurrentPath.Length + 1)
            $EntryName = $RelativePath.Replace("\", "/")

            $Entry = $Archive.CreateEntry($EntryName, [System.IO.Compression.CompressionLevel]::Optimal)
            $EntryStream = $Entry.Open()
            try {
                $FileStream = [System.IO.File]::OpenRead($File.FullName)
                try {
                    $FileStream.CopyTo($EntryStream)
                } finally {
                    $FileStream.Dispose()
                }
            } finally {
                $EntryStream.Dispose()
            }
        }
    } finally {
        $Archive.Dispose()
        $ZipStream.Dispose()
    }

    Write-Host "Created: $ZipName"
}