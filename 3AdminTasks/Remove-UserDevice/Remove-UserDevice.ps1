#Remove-UserDevice.ps1
#Written by: Jeff Brusoe
#Last Updated: October 7, 2019
#
#Purpose: This file removes access to a user's mobile devices.
#
#This file assumes a connection has already been established to the cloud.
#If this has not been done, run Connect-ToOffice365.ps1.
 
 [CmdletBinding()]
 param (
	[Parameter(Mandatory=$true)][string]$PrimarySMTPAddress
	)

#Configure environment
Clear-Host
Set-StrictMode -Version Latest
$host.ui.RawUI.WindowTitle = "PowerShell Window Title"

#Get list of mobile devices
try
{
	$MobileDevices = Get-MobileDevice -Mailbox $PrimarySMTPAddress -ErrorAction Stop
}
catch
{
	Write-Warning "Error getting list of mobile devices. Program is exiting."
	return
}

if (($MobileDevices | Measure).Count -gt 0)
{
	foreach ($MobileDevice in $MobileDevices)
	{
		Write-Output $("Mobile Device Name: " + $MobileDevice.Name)
		$MobileDevice | Remove-MobileDevice
	}
}
else
{
	Write-Output "No mobile devices to remove."
}