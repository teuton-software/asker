<#
Windows ASKER uninstallation
author: Francisco Vargas Ruiz
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

Write-Host "[0/3.INFO] WINDOWS ASKER uninstallation"

Write-Host "[1/3.INFO] Uninstalling PACKAGES..."
If (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    choco uninstall git ruby -y --remove-dependencies
}

Write-Host "[2/3.INFO] Uninstalling asker"
gem uninstall asker-tool

Write-Host "[3/3.INFO] Finish!"
