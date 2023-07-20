# Get the latest release of hidapitester (https://github.com/todbot/hidapitester/releases)
# Original Script by @MarkTiedemann (https://github.com/MarkTiedemann)
# Source: https://gist.github.com/MarkTiedemann/c0adc1701f3f5c215fc2c2d5b1d5efd3

function Get-HidApiTester {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Destination
    )
    $repo = "todbot/hidapitester"
    $file = "hidapitester-windows-x86_64.zip"

    $releases = "https://api.github.com/repos/$repo/releases"

    Write-Host -ForegroundColor Blue "Determining latest release for $repo"
    $tag = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name

    $download = "https://github.com/$repo/releases/download/$tag/$file"
    $name = $file.Split(".")[0]
    $zip = "$name-$tag.zip"

    $filePath = "$Destination\$zip"
    if (-not(Test-Path -Path $Destination)) {
        Write-Host -ForegroundColor Blue "The folder $Destination doesn't exist. Creating now..."
        New-Item -ItemType Directory -Path $Destination
    }

    Write-Host -ForegroundColor Blue "Dowloading from '$download' and moving to '$filePath'"
    Invoke-WebRequest $download -OutFile $filePath

    Write-Host -ForegroundColor Blue "Extracting release files from $filePath"
    Expand-Archive $filePath -Force -DestinationPath $Destination

    Write-Host -ForegroundColor Green "SUCCESS: $repo has been downloaded"
}
