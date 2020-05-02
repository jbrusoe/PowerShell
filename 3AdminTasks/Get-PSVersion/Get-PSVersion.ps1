#Method 1
#PS version 3 or greater must be present for this to work.
Write-Output 'Method 1: Get PowerShell version from $PSVersionTable'
Write-Output $PSVersionTable

#Method 2: Using $host automatic variable
Write-Output $("`n`nMethod 2: Get PowerShell version from " + '$host.Version')
Write-Output $host.Version

#Metho 3: Using Get-Host
Write-Output "`n`nMethod 3: Get PowerShell version from Get-Host | Select Version"
Get-Host | Select Version