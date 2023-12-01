<#
    Random PowerShell Dev - samples, examples, testing and more...
>#

<#
    Local User Properties
#>
Get-WmiObject -Class Win32_UserProfile | Get-Member # return all properties of a local user
Get-WmiObject -Class Win32_UserProfile | Select-Object LocalPath,LastUseTime,Special # return some useful properties
Get-WmiObject -Class Win32_UserProfile | ForEach-Object { # iterate over all (non special) local users and return their Local Path only
    If (!$_.Special) {
        Write-Host $_.LocalPath
    }
}

<#
    File Management - return FullName of all files within a directory
#>
try {
    Get-ChildItem -Path C:\Users\my.name -ErrorAction Stop | ForEach-Object {
        Write-Host $_.FullName
    }
} catch [System.UnauthorizedAccessException] {
    Write-Host "ERROR! Check Permissions and Try Again!"
    Write-Host $_.Exception.Message
} catch [System.Management.Automation.ItemNotFoundException] {
    Write-Host "ERROR! Directory Does Not Exist!"
    Write-Host $_.Exception.Message
} catch {
    Write-Host "Unhandled ERROR! NO!"
    Write-Host $_.Exception.Message
    Write-Host $_.ScriptStackTrace
    Write-Host $_.Exception
    Write-Host $_.ErrorDetails
}

<#
    File Management - monitor a file for changes and print out in real time
#>
Get-Content -Path .\TestValues.txt -Wait

<#
    File Management - read and write to local .txt file
#>
$FileContents = Get-Content -Path .\TestValues.txt | ForEach-Object {
    Write-Host "-" $_.Replace('change me', 'changed')
}
$FileContents.ForEach({
    Write-Host ">" $_
})
Write-Host "First Line >" $FileContents[0] # return first line from file in

<#
    Object Management
#>
$TestPerson = New-Object PSObject -Property @{ Name='james'; Age=18; Location='School' }
Write-Host $TestPerson.Name
if ($TestPerson.Age -gt 25) {
    Write-Host $TestPerson.Name 'is old!'
} else {
    Write-Host $TestPerson.Name 'is young!'
}
$TestPerson | Select-Object * | Format-Table
