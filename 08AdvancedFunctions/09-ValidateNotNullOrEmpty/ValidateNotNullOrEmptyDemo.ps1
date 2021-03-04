function Test-ValidateNotNullOrEmpty
{
	[CmdletBinding()]
	param (
		[ValidateNotNullOrEmpty()]
		[string]$Name
	)
	
	if ($null -eq $Name) {
		Write-Output "Name parameter wasn't used in function call"
	}
	else {
		Write-Output $Name
	}
}

Write-Output "Function call with -Name parameter"
Test-ValidateNotNullOrEmpty -Name "Jeff"

Write-Output `n'Function call with $null value for -Name'
Test-ValidateNotNullOrEmpty -Name $null

Write-Output "`nFunction call with empty string for -Name"
Test-ValidateNotNullOrEmpty -Name ""

Write-Output "`nFunction call without using -Name parameter"
Test-ValidateNotNullOrEmpty