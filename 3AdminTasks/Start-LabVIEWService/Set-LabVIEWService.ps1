#Set-LabVIEWService.ps1
#Written by: Jeff Brusoe
#Last Updated: December 1, 2019

param (
	[string]$ServiceNames = "LV.txt",
	[switch]$StopServices,
	[switch]$Testing
	)

#Environment configuration
Clear-Host
$Error.Clear()

$TranscriptLog = $PSScriptRoot + "\Logs\" + (Get-Date -Format yyyy-MM-dd-HH-mm) + "-SessionTranscript.txt"
Write-Verbose "Transcript Log File: $TranscriptLog"

Start-Transcript $TranscriptLog
#End of environment configuration


#Select services to start/stop
if ($StopServices)
{
	#GWMI is used here in order to filter on display name
	$LVServices = Get-WMIObject Win32_Service | where {$_.DisplayName -clike "*NI *" -AND $_.State -eq "Running" }
}
else
{
	$LVServices = Get-Content $ServiceNames
}

foreach ($LVService in $LVServices)
{	
	try
	{
		if (!$StopServices)
		{
			Write-Output "Starting Service: $LVService"
			
			Get-Service $LVService.Trim() | Start-Service -ErrorAction Stop
			Write-Output "Successfully started service"
		}
		else
		{
			Write-Output $("Stopping Service: " + $LVService.DisplayName)
			
			$LVService | Stop-Service -ErrorAction Stop -Force
			Write-Output "Successfully stopped service"
		}
	}
	catch
	{
		Write-Warning "Error starting/stopping service"
		
		if ($Testing)
		{
			return
		}
	}
	
	Write-Output "*******************"
}

Stop-Transcript