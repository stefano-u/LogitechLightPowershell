param(
    [switch]$On,
    [switch]$Off
)

# Variables
$utilsFolder = "$PSScriptRoot\utils"
$hidApiTesterFolder = "$PSScriptRoot\hidApiTester\"
$hidApiTesterFile = "hidapitester.exe"
$global:hidApiTesterFilePath = "$hidApiTesterFolder\$hidApiTesterFile"

# Import all util scripts
. "$utilsFolder\LogiLitraFunctions.ps1"
. "$utilsFolder\GetLatestHIDAPITester.ps1"

# Get HIDAPITester (if it doesn't exist)
if (-not(Test-Path -Path $hidApiTesterFilePath -PathType Leaf)) {
    Write-Warning "$hidApiTesterFilePath doesn't exist. Downloading now..."
    Get-HidApiTester -Destination $hidApiTesterFolder
}

$lights = Get-LitraLight -HIDAPItesterPath $hidApiTesterFilePath

foreach ($light in $lights) {
    if ($On) {
        Start-LitraLight -vidpid $light.vidpid -OpenPath $light.path -HIDAPItesterPath $hidApiTesterFilePath
    }
    elseif ($Off) {
        Stop-LitraLight -vidpid $light.vidpid -OpenPath $light.path -HIDAPItesterPath $hidApiTesterFilePath
    }
    else {
        Start-LitraLight -vidpid $light.vidpid -OpenPath $light.path -HIDAPItesterPath $hidApiTesterFilePath
    }
}