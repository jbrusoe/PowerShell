#Get-RandomProduct.ps1
#PowerShell - Basic Function Demonstration
#Written by: Jeff Brusoe
#Last Updated: July 2, 2020

function Get-RandomProduct
{
	param (
		[int]$Min = 1,
		[int]$Max = 100
	)
	
	$Product = (Get-Random -Min $Min -Max ($Max+1)) * (Get-Random -Min $Min -Max ($Max+1))
	return $Product
}

for ($i = 1; $i -lt 11; $i++)
{
	Write-Output $("$i - " + (Get-RandomProduct))
}