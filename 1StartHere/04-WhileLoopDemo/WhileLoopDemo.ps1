#PowerShell while loop demo

Write-Output "PowerShell While Loop Demonstration"

$i = 1 #initializes loop variable

while ($i -le 10)
{
	Write-Output "Current Value: $i" 
	$i++
	
	if ($i -gt 10)
	{
		Write-Output "Loop exit condition has been reached."
	}
}