# Litra Glow and Litra Beam Powershell Controller
# Originally based off original script by @poiriersimon (https://github.com/poiriersimon)
# Based on https://www.reddit.com/r/LogitechG/comments/sacz2x/comment/j7doia4/?utm_source=share&utm_medium=web2x&context=3

function Set-HIDAPItester {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $vidpid,
        [Parameter(Mandatory = $true)]
        [string] $OpenPath,
        [Parameter(Mandatory = $true)]
        [string] $output,
        [Parameter(Mandatory = $true)]
        [string] $usagePage,
        [Parameter(Mandatory = $true)]
        [string] $HIDAPItesterPath
    )
    $null = &($HIDAPItesterPath) --vidpid $vidpid --usagePage $usagePage --open-path $OpenPath --send-output $output
}

function Get-LitraLight {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $HIDAPItesterPath,
        [switch] $Beam,
        [switch] $Glow
    )
    if ($Beam) {
        $LitraRaw = &($HIDAPItesterPath) --vidpid 046d/c901 --usagePage FF43 --list-detail
    }
    elseif ($Glow) {
        $LitraRaw = &($HIDAPItesterPath) --vidpid 046d/c900 --usagePage FF43 --list-detail
    }
    else {
        $LitraRaw = &($HIDAPItesterPath) --usagePage FF43 --list-detail
    }
    #$litraRaw
    $i = 0
    [Array]$LitraLights = @()
    $LitraLight = New-Object PSObject
    foreach ($line in $litraRaw) {
        $i++
        if ($i -eq 1) {
            $name = "vidpid"
            $value = $line.split(":")[0].trim()
        }
        else {
            $name = $line.split(":")[0].trim()
            $value = $line.split(":")[-1].trim()
        }
        if (!$([string]::IsNullOrempty($name))) {
            $LitraLight | Add-Member NoteProperty -Name $name -Value $value
        }
        if ($i -gt 8) {
            $i = 0
            [Array]$LitraLights += $LitraLight
            $LitraLight = New-Object PSObject
        }
    }
    return $LitraLights
}

function Set-LitraLight {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $HIDAPItesterPath,
        [Parameter(Mandatory = $true)]
        [string] $vidpid,
        [Parameter(Mandatory = $true)]
        [string] $OpenPath,
        [ValidateRange(1, 100)]
        [int] $Brightness,
        [ValidateRange(2700, 6500)]
        [int] $temperature
    )
    if ($Brightness -gt 0) {
        [int]$brightnessvalue = [math]::floor(31 + ($Brightness / 100 * 368))
        $brightnessvalue
        $hex = $brightnessvalue | Format-Hex
        $hex
        $output = "0x11,0xFF,0x04,0x4F,0x" + $hex.HexBytes.Split(" ")[1] + ",0x" + $hex.HexBytes.Split(" ")[0]
        Set-HIDAPItester -vidpid $vidpid -usagePage ff43 -OpenPath $OpenPath -output $output -HIDAPItesterPath $HIDAPItesterPath
    }
    if ($temperature -gt 0) {
        $hex = $temperature | Format-Hex
        $hex
        $output = "0x11,0xFF,0x04,0x9D,0x" + $hex.HexBytes.Split(" ")[1] + ",0x" + $hex.HexBytes.Split(" ")[0]
        Set-HIDAPItester -vidpid $vidpid -usagePage ff43 -OpenPath $OpenPath -output $output -HIDAPItesterPath $HIDAPItesterPath
    }
}


function Start-LitraLight {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $HIDAPItesterPath,
        [Parameter(Mandatory = $true)]
        [string] $vidpid,
        [Parameter(Mandatory = $true)]
        [string] $OpenPath
    )
    $output = "0x11,0xFF,0x04,0x1D,0x01"
    Set-HIDAPItester -vidpid $vidpid -usagePage ff43 -OpenPath $OpenPath -output $output -HIDAPItesterPath $HIDAPItesterPath
}

function Stop-LitraLight {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $vidpid,
        [Parameter(Mandatory = $true)]
        [string] $OpenPath,
        [Parameter(Mandatory = $true)]
        [string] $HIDAPItesterPath
    )
    $output = "0x11,0xFF,0x04,0x1D,0x00"
    Set-HIDAPItester -vidpid $vidpid -usagePage ff43 -OpenPath $OpenPath -output $output -HIDAPItesterPath $HIDAPItesterPath
}