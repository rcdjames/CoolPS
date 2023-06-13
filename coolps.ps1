Write-Host "hello, CoolPS!" -ForegroundColor Red -BackgroundColor Black

Get-ExecutionPolicy # check the execution policy before running scripts

Set-ExecutionPolicy

Update-Help

Get-Help Get-Service -Examples

Get-Alias * # return all aliases available on the system

Get-Command -Name *user*

Get-Location | Get-Member

Write-Host ("hello, powershell!", "why hello there!") -Separator "++" -ForegroundColor Green -BackgroundColor Black

Get-Service | Select-Object -Property DisplayName, Status, StartType | Where-Object {$_.StartType -eq "Automatic"}

Get-Service | Select-Object -Property DisplayName, Status, ServiceName | Out-GridView -PassThru | Restart-Service -Verbose

gps | ? {$_.MainWindowTitle} | Format-Table ID, Name, MainWindowTitle -Autosize # note use of alias gps

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

# copy over identity memberships and properties from one account to another
$SourceUser = "FirstName.LastName"
$DestinationUser ="FirstName.LastName"
Get-ADUser -Identity $SourceUser -Properties memberof  | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $DestinationUser

# stop processes tool from grid view
Get-Process | Select-Object -Property Id, ProcessName | Out-GridView -PassThru | Stop-Process -Force

# returns various printer details to file
Get-Printer * | Select-Object Name, ShareName, Comment, Location, DriverName, Portname, PrinterStatus, Type, DeviceType, PrintProcessor, CimClass | Format-Table | Out-File -FilePath C:\PrinterInfo.txt

# returns all group memberships and a total count
$UserName = 'firstname.surname'
Write-Output $UserName
Get-ADPrincipalGroupMembership $UserName | Select name | Sort-Object name
(Get-ADUser $UserName –Properties MemberOf).MemberOf.Count


### commands to remote pc ###

# returns system uptime
powershell.exe -Command "Write-Host 'System Uptime'; (get-date) - (gcim Win32_OperatingSystem).LastBootUpTime | Select-Object Days, Hours, Minutes, Seconds"
