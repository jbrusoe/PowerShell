function Get-RandomProduct
{
	<#
		.SYNOPSIS
			This function randomly generates two numbers and returns their product.
			
		.DESCRIPTION
			In addition to randomly generating the two numbers and returning their product, this function
			also allows the use of the -Verbose parameter and demonstrates PowerShell's comment based help system.
			
		.PARAMETER Min
			The minimum value of the randomly generated numbers
		
		.PARAMETER Max
			The maximum value of the randomly generated numbers
			
		.NOTES
			Written by: Jeff Brusoe	
			Last Updated: July 2, 2020
	#>
	
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

Get-RandomProduct -Verbose

Get-Help Get-RandomProduct