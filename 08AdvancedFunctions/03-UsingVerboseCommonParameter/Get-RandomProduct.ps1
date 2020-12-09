#Get-RandomProduct.ps1
#Using the -Verbose common parameter
#Written by: Jeff Brusoe
#Last Updated: July 2, 2020

function Get-RandomProduct
{
	[CmdletBinding()]
	param (
		[int]$Min = 1,
		[int]$Max = 100
	)
	
	$FirstNumber = Get-Random -Min $Min -Max ($Max+1)
	$SecondNumber = Get-Random -Min $Min -Max ($Max+1)
	
	Write-Verbose "First Number: $FirstNumber" | Out-Host
	Write-Verbose "SecondNumber: $SecondNumber" | Out-Host
	
	$Product =  $FirstNumber * $SecondNumber 
	return $Product
}

for ($i = 1; $i -lt 11; $i++)
{
	Write-Output $("$i - " + (Get-RandomProduct -Verbose))
	Write-Output "************************"
}