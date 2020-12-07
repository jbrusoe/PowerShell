#PowerShell Invoke-WebRequest Demo
#Written by:Jeff Brusoe (jbrusoe@gmail.com)

$URLs = "https://www.microsoft.com/","https://www.nscl.msu.edu/"

foreach ($URL in $URLs)
{
	Write-Output "`nCurrent URL: $URL`n"
	
	$Links = (Invoke-WebRequest -Uri $URL).Links
	$LinkCount = 1
	
	foreach ($Link in $Links)
	{
		if ($Link.href.toLower().indexOf("http") -lt 0)
		{
			Write-Output $("Link $LinkCount`: $URL" + $Link.href)
		}
		else
		{
			Write-Output $("Link $LinkCount`: " + $Link.href)
		}
		
		$LinkCount++
	}
}