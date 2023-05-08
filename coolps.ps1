Write-Host "hello, coolps!" -ForegroundColor Red -BackgroundColor Black

# returns all services with automatic start type
Get-Service | Select-Object -Property DisplayName, Status, StartType | Where-Object {$_.StartType -eq "Automatic"}

# returns a table view of running processes
Get-Process | Where-Object {$_.MainWindowTitle} | Format-Table ID, Name, MainWindowTitle -Autosize

# returns various properties of a local user in a grid view
$TargetUser = "FirstName.LastName"
Get-LocalUser -Name $TargetUser | Select-Object -Property Name, AccountExpires, LastLogon, FullName, PasswordExpires, PasswordLastSet, PasswordRequired, SID, UserMayChangePassword | Out-GridView

# returns name and last write time of all files within a directory
$ScanTarget = "C:\ScanTarget\"
$SaveTarget = "C:\ScanFilesOut.txt"
Get-ChildItem -Path $ScanTarget -Recurse | Select-Object Name, LastWriteTime | Sort-Object -Property LastWriteTime -Descending | Out-File -FilePath $SaveTarget

# copy over membership from one account to another
$SourceUser = "FirstName.LastName"
$DestinationUser ="FirstName.LastName"
Get-ADUser -Identity $SourceUser -Properties memberof  | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $DestinationUser
