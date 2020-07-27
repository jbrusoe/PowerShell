function Get-RandomNumber
{
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)][int]$Min,
		[Parameter(Mandatory=$true)][int]$Max
	)
	
	$RandomNumber = Get-Random -Min $Min -Max $Max
	return $RandomNumber
}

for ($i = 1; $i -lt 21; $i++)
{
	#Version1
	Write-Output $("$i - " + (Get-RandomNumber -Min 1 -Max 101))
	#Version 2 - Write-Output $("$i - " + (Get-RandomNumber))
}