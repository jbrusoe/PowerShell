#PowerShell while loop demo

Write-Output "PowerShell While Loop Demonstration"

$i = 1 #initializes loop variable

Write-Output "`nCount from 1 to 10 with while loop"
while ($i -le 10)
{
	Write-Output "Current Value: $i" 
	$i++
	
	if ($i -gt 10) {
		Write-Output "Loop exit condition has been reached."
	}
}

Write-Output "`nCount from 10 to 1 with while loop"
while ($i -gt 0)
{
	Write-Output "Current Value: $i" 
	$i--
	
	if ($i -lt 1) {
		Write-Output "Loop exit condition has been reached."
	}
}