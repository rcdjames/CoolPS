<#
    PSWU_Check-Install_ISE.ps1
    23/10/2023
    Run in Windows PowerShell ISE
    List all available Windows Updates and prompt to install
    
#>
Get-WindowsUpdate -MicrosoftUpdate -BrowseOnly -ShowPreSearchCriteria -Verbose

# incomplete...
