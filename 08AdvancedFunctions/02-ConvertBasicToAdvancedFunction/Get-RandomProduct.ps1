#Get-RandomProduct.ps1
#Convert basic function to advanced function
#Written by: Jeff Brusoe
#Last Updated: July 2, 2020

#Adding [CmdletBinding()] turns this into an advanced function.
#That allows the function to have access to the common parameters (-Verbose, -ErrorAction, etc.
#For more information on this, see the following links:
#1. https://www.itprotoday.com/powershell/what-does-powershells-cmdletbinding-do
#2. https://devblogs.microsoft.com/scripting/introduction-to-advanced-powershell-functions/

function Get-RandomProduct
{
	[CmdletBinding()]
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