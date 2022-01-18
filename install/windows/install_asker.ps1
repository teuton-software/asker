<#
Windows ASKER installation
author: Francisco Vargas Ruiz
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

Write-Host "[0/3.INFO] WINDOWS ASKER installation"

Write-Host "[1/3.INFO] Installing PACKAGES..."
If (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

choco install -y git
choco install -y ruby

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv

Write-Host "[2/3.INFO] gem installation"
gem install asker-tool

Write-Host "[3/3.INFO] Finish!"
