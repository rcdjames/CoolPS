Write-Host "hello, coolps!" -ForegroundColor Red -BackgroundColor Black

Get-ExecutionPolicy

Set-ExecutionPolicy

Update-Help

Get-Help Get-Service -Examples

Get-Alias *

Get-Command -Name *user*

Get-Location | Get-Member

Write-Host ("hello, powershell!", "why hello there!") -Separator "++" -ForegroundColor Green -BackgroundColor Black

Get-Service | Select-Object -Property DisplayName, Status, StartType | Where-Object {$_.StartType -eq "Automatic"}

Get-Service | Select-Object -Property DisplayName, Status, ServiceName | Out-GridView -PassThru | Restart-Service -Verbose

gps | ? {$_.MainWindowTitle} | Format-Table ID, Name, MainWindowTitle -Autosize

Get-Process | Where-Object {$_.MainWindowTitle}

Get-Process | Select-Object -Property ID, Name, Description | Out-GridView

Get-Process | Where-Object {$_.MainWindowTitle} | Out-GridView

Get-History | Out-GridView -PassThru | Invoke-Expression

Write-Warning "this is a warning!"

# returns all services with automatic start type
Get-Service | Select-Object -Property DisplayName, Status, StartType | Where-Object {$_.StartType -eq "Automatic"}

# returns a table view of running processes
Get-Process | Where-Object {$_.MainWindowTitle} | Format-Table ID, Name, MainWindowTitle -Autosize

# returns group membership of the current user in a grid view
Get-LocalGroup | Select-Object * | Out-GridView

# returns various properties of a local user in a grid view
$TargetUser = "FirstName.LastName"
Get-LocalUser -Name $TargetUser | Select-Object -Property Name, AccountExpires, LastLogon, FullName, PasswordExpires, PasswordLastSet, PasswordRequired, SID, UserMayChangePassword | Out-GridView

# returns name and last write time of all files within a directory
$ScanTarget = "C:\ScanTarget\"
$SaveTarget = "C:\ScanFilesOut.txt"
Get-ChildItem -Path $ScanTarget -Recurse | Select-Object Name, LastWriteTime | Sort-Object -Property LastWriteTime -Descending | Out-File -FilePath $SaveTarget

# recursive scan for files within a directory
Get-ChildItem .\Downloads -Recurse -Depth 2 -Include *.png | Out-GridView
Get-ChildItem .\Downloads -Recurse -Depth 2 | Out-GridView

# copy over membership from one account to another
$SourceUser = "FirstName.LastName"
$DestinationUser ="FirstName.LastName"
Get-ADUser -Identity $SourceUser -Properties memberof  | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $DestinationUser

# stop processes in a grid view
Get-Process | Select-Object -Property Id, ProcessName | Out-GridView -PassThru | Stop-Process -Force

# returns various printer details to file
Get-Printer * | Select-Object Name, ShareName, Comment, Location, DriverName, Portname, PrinterStatus, Type, DeviceType, PrintProcessor, CimClass | Format-Table | Out-File -FilePath C:\PrinterInfo.txt

### cmd commands ###

# include /? with any command to return help text

# returns report on wlan performance and stats in .html format
netsh wlan show wlanreport
netsh interface show interface
# returns report of currently applied group policies
gpresult /R
gpresult /h C:\GPO-Report.html /f # saves to .html format
ipconfig /all
ipconfig /all | findstr "DNS"
ipconfig /release
ipconfig /renew
ipconfig /displaydns
ipconfig /flushdns
whoami
hostname
tracert 
systeminfo
scp
subst
explorer
doskey /history
nslookup [host] [server]
cls # clear command window
powercfg /energy
powercfg /batteryreport
assoc
chkdsk /f /r 
sfc /scannow
tasklist
taskkill /f /pid [PID]
ping -t
tracert -d [host]
netstat
netstat -af
netstat -o
netstat -e -t 5
route print
shutdown /f /t 10 # force reboot in 10 seconds time
DISM.exe /Online /Cleanup-image /Scanhealth
DISM.exe /Online /Cleanup-image /Restorehealth
DISM.exe /Online /Cleanup-image /startcomponentcleanup
sfc /scannow
