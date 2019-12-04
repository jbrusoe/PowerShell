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

$LVServices = Get-Content $ServiceNames

if ($StopServices)
{
	$LVServices = Get-WMIObject Win32_Service | where {$_.DisplayName -clike "*NI *" -AND $_.State -eq "Running" }
}

foreach ($LVService in $LVServices)
{	
	
	
	try
	{
		if (!$StopServices)
		{
			Write-Output "Starting Service: $LVService"
			
			Get-Service $LVService.Trim() | Start-Service -ea "Stop"
			Write-Output "Successfully started service"
		}
		else
		{
			Write-Output $("Stopping Service: " + $LVService.DisplayName)
			
			$LVService | Stop-Service -ea "Stop" -Force
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