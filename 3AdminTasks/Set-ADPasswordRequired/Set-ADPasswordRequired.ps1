#5Set-PasswordRequired.ps1
#
#Written by: Jeff Brusoe
#Last Modified: December 12, 2017
#Version: 1.0
#
#This file sets the password required attribute on users in the HS domain.
#It does not need to be authenticated to the cloud to do this.

#Environment and variable initialization
Clear-Host
$Error.Clear()
$UserNumber = 0

Set-StrictMode -Version Latest
Set-Location $PSScriptRoot

#Change PowerShell window title
$Host.UI.RawUI.WindowTitle = "5Set-PasswordRequired.ps1"

Start-Transcript $("c:\ad-development\5Set-PasswordRequired\Logs\" + (Get-Date -Format yyyy-MM-dd-HH-mm) + "-Set-PasswordRequired.txt") 

$ErrorLogFile = "c:\ad-development\5Set-PasswordRequired\Logs\" + (Get-Date -Format yyyy-MM-dd-HH-mm) + "-Set-PasswordRequired-Error.txt"

New-Item $ErrorLogFile -type File -Force

Write-Output "Getting list of AD users..."
$ADUsers = Get-ADUser -Filter * -ResultSetSize $null

$UserNumber = 0

Write-Output "Starting to loop through AD Users"

foreach ($ADUser in $ADUsers)
{
	$UserNumber++
	
	"Current User: " + $ADUser.UserPrincipalName
	"User Number: $UserNumber"
	
	"Setting Password Required"
	
	try
	{
		#Reference: https://technet.microsoft.com/en-us/library/ee617249.aspx
		$ADUser | Set-ADAccountControl -PasswordNotRequired $false -ErrorAction Stop
	}
	catch
	{
		"Error setting password required flag"
		Add-Content -Value $ADUser.UserPrincipalName -Path $ErrorLogFile
	}
	
	Write-Output "*****************************"
}

Stop-Transcript

Exit