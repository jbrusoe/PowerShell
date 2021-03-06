#PowerShell Bubble Sort Demo
#Written by: Jeff Brusoe
#Last Updated: March 6, 2021

Set-StrictMode -Version Latest

#Generate an array of random numbers
[int[]]$ArrayToSort = @(0)*50

Write-Output "Original Array:"

for ($i = 0; $i -lt 50; $i++)
{
	$NewRandomNumber = Get-Random -Minimum 1 -Maximum 1001
	
	#Note: Write-Host is used here for the -NoNewLine switch
	#This helps with the output format.
	if (($i+1)%10 -eq 0) {
		Write-Host $NewRandomNumber
	}
	else {
		Write-Host "$NewRandomNumber`t" -NoNewLine
	}
	
	$ArrayToSort[$i] = $NewRandomNumber
}

Write-Output `n"**********************************"

#Array has been generated at this point

#Begin bubble sort algorithm
$PassNumber = 1
$ElementSwitched = $true

while ($ElementSwitched) {
	$ElementSwitched = $false
	
	Write-Output "`nPass Number: $PassNumber`n"
	$PassNumber++
	
	for ($i = 1; $i -lt 50; $i++) {
		if ($ArrayToSort[$i-1] -gt $ArrayToSort[$i]) {
			#Elements will be swapped
			$ElementSwitched = $true
			$Temp = $ArrayToSort[$i]
			$ArrayToSort[$i] = $ArrayTOSort[$i-1]
			$ArrayToSort[$i-1] = $Temp
		}
	}
	
	for ($i = 0; $i -lt 50; $i++) {
		if (($i+1)%10 -eq 0) {
			Write-Host $ArrayToSort[$i]
		}
		else {
			$x = $ArrayToSort[$i]
			Write-Host "$x`t" -NoNewLine
		}
	}
	
	Write-Output `n"**********************************"
}