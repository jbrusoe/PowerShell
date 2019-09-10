param (
	[switch]$StopServices
	)

$services = "lkClassAds","lkTimeSync","mxssvr","NIApplicationWebServer","niauth","NIDomainService","niLXIDiscovery","nimDNSResponder","NINetworkDiscovery","nipxicmsvc","nipxirmu","niroco","NiSvcLoc","NISystemWebServer","NITaggerService"

foreach ($service in $services)
{
	$Error.Clear()
	
	Write-Output "Service Name: $service"
	
	try
	{
		if (!$StopServices)
		{
			Get-Service $service | Start-Service -ea "Stop"
			Write-Output "Successfully started service"
		}
		else
		{
			Get-Service $service | Stop-Service -ea "Stop" -Force
			Write-Output "Successfully stopped service"
		}
	}
	catch
	{
		Write-Warning "Error starting/stopping service"
		return
	}
	
	Write-Output "*******************"
}