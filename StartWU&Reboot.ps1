Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
// Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Install-Module -Name PSWindowsUpdate -Force
Import-Module PSWindowsUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
