<#
Windows ASKER uninstallation
version: 20190821
author: Francisco Vargas Ruiz
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

$AskerPath = $env:ProgramFiles + "\asker"

Write-Host "[0/4.INFO] WINDOWS ASKER uninstallation"

Write-Host "[1/4.INFO] Uninstalling PACKAGES..."
If (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    choco uninstall git ruby -y --remove-dependencies
}

Write-Host "[2/4.INFO] Uninstalling asker"
Remove-Item -Force -Recurse $AskerPath

Write-Host "[3/4.INFO] Removing asker from system environment PATH variable"
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
If (!$CurrentPath.Contains($AskerPath)) {
    [Environment]::SetEnvironmentVariable("Path", $CurrentPath.Replace($AskerPath, ""), [EnvironmentVariableTarget]::Machine)
}

Write-Host "[4/4.INFO] Finish!"
