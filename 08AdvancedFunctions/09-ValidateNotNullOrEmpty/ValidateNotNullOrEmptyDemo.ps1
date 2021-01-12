function Test-ParameterAttribute
{
	[CmdletBinding()]
	param (
		[ValidateNotNullOrEmpty()]
		[string]$Name
	)
	
	Write-Output $Name
}

Write-Output "Function call with -Name parameter"
Test-ParameterAttribute -Name "Jeff"

Write-Output "`nFunction call with $null value for -Name"
Test-ParameterAttribute -Name $null

Write-Output "`nFunction call with empty string for -Name"
Test-ParameterAttribute -Name ""