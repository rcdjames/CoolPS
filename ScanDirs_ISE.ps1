<#
    ScanDirs_ISE.ps1
    10/10/2023
    Run script with Windows PowerShell ISE
    Scan a directory for files with a specified file extension
#>
$ScanThisDir = "c:\media\videos" # specify path to the directory for recursive scanning
$FindThisExt = "pdf" # specifcy the target extension
$FoundFiles = @()
$IgnoreFiles = @()
Get-ChildItem -Path $ScanDir -Force -Recurse | Where-Object {
    # check extension matches file
    if ($_.Extension -eq ".{0}" -f $ScanForExt) {
        $FoundFiles += $_ # append if extension matches
    } else {
        $IgnoreFiles += $_ # append if extension does NOT match
    }
}
# summary of total hits found during scan
Write-Host ("Total hits for {0}: {1}" -f $ScanForExt.ToUpper(), $FoundFiles.Count) -BackgroundColor Green -ForegroundColor Whit
$FoundFiles | ForEach-Object {
    Write-Host ("{0}" -f $_.Name) -BackgroundColor Black -ForegroundColor Green
}
Write-Host ("Total ignored for {0}: {1}" -f $ScanForExt.ToUpper(), $IgnoreFiles.Count) -BackgroundColor Red -ForegroundColor White
$IgnoreFiles | ForEach-Object {
    Write-Host ("{0}" -f $_.Name) -BackgroundColor Black -ForegroundColor Red
}
