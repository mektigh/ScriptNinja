<#
.SYNOPSIS
    Enables support for long file paths in Windows.
.DESCRIPTION
    This script modifies the Windows Registry to enable support for long file paths by setting the "LongPathsEnabled" registry key.
.PARAMETER None
    This script does not accept parameters.
.EXAMPLE
    .\Enable-LongPaths.ps1
    Runs the script and enables long file path support.
.NOTES
    Author: Mektigh
    Date: 2025-02-02
    Version: 1.0
    Compatibility: Windows 10 and later
#>

# PowerShell-skript för att aktivera långa sökvägar
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem"
$registryName = "LongPathsEnabled"
$registryValue = 1

# Kontrollera om nyckeln redan finns
if (Test-Path $registryPath) {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue
    if ($currentValue -ne $null -and $currentValue.$registryName -eq $registryValue) {
        Write-Output "LongPathsEnabled är redan aktiverat."
    } else {
        Set-ItemProperty -Path $registryPath -Name $registryName -Value $registryValue -Type DWord
        Write-Output "LongPathsEnabled har aktiverats."
    }
} else {
    Write-Output "Registervägen finns inte, skapar och sätter värdet..."
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $registryName -Value $registryValue -PropertyType DWord -Force | Out-Null
    Write-Output "LongPathsEnabled har skapats och aktiverats."
}
