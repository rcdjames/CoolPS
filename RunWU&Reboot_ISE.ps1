<#
    RunWU&Reboot_ISE
    28/09/2023
    Run script with Windows PowerShell ISE
    Keep your Windows system up to date!
#>
$ExecPolicy = Get-ExecutionPolicy
if ($ExecPolicy -ne "RemoteSigned") # need at least RemoteSigned to install the external library
{
    Write-Host "ERROR - Review your Execution Policy!" $ExecPolicy -BackgroundColor Red
    Write-Host "Set-ExecutionPolicy RemoteSigned -Force" -BackgroundColor Green
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
    $ExecPolicy = Get-ExecutionPolicy; Write-Host "DONE - Changed Execution Policy:" $ExecPolicy -ForegroundColor Green
}
Try {
    Install-PackageProvider -Name NuGet -Force
    Install-Module -Name PSWindowsUpdate -Force # install external library
    Import-Module PSWindowsUpdate
    Set-ExecutionPolicy -ExecutionPolicy Restricted -Force # restore Execution Policy to Restricted once done installing library
    $ExecPolicy = Get-ExecutionPolicy; Write-Host "DONE - Changed Execution Policy:" $ExecPolicy -ForegroundColor Green   
    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -Verbose # no automatic reboot is the default
    $Wshell = New-Object -ComObject Wscript.Shell
    $Wshell.Popup("Windows Update operation has completed. Reboot the system now.", 0, "WU Completed", 0x0) # pop up alert once update is done
} Catch {
    Write-Host "Error - Failed to install Windows Updates!" -BackgroundColor Red
    $ErrorMsg = $Error[0].Exception.GetType().FullName
    Write-Host $ErrorMsg -BackgroundColor Red
    Write-Host $Error
    Break
}
