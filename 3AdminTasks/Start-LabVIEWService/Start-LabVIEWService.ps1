param (
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

$LVServices = "lkClassAds","lkTimeSync","mxssvr","NIApplicationWebServer","niauth","NIDomainService","niLXIDiscovery","nimDNSResponder","NINetworkDiscovery","nipxicmsvc","nipxirmu","niroco","NiSvcLoc","NISystemWebServer","NITaggerService"

foreach ($LVService in $LVServices)
{	
	Write-Output "Service Name: $LVService"
	
	try
	{
		if (!$StopServices)
		{
			Get-Service $LVService | Start-Service -ea "Stop"
			Write-Output "Successfully started service"
		}
		else
		{
			Get-Service $LVService | Stop-Service -ea "Stop" -Force
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