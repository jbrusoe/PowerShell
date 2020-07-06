#PowerShell - Command line parameters demonstration
#Written by: Jeff Brusoe
#Last Updated: October 16, 2018

param (
	[string]$FirstName = "Jenny"
)

Write-Output "FirstName: $FirstName"