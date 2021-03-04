#Demo of -WhatIf parameter
#Written by: Jeff Brusoe
#Last Updated: January 11, 2021

function Test-WhatIfConfirm
{
	[CmdletBinding(SupportsShouldProcess=$true,
					ConfirmImpact='Medium')]
	param()
	
	if ($PSCmdlet.ShouldProcess("Running Get Service")) {
		Get-Service | Select-Object -First 10
	}
}

Write-Output "`n`nWithout -WhatIf"
Write-Output "Without -Confirm"
Test-WhatIfConfirm

Write-Output "`n`nWith -WhatIf"
Write-Output "Without -Confirm"
Test-WhatIfConfirm -WhatIf

Write-Output "`n`nWithout -WhatIf"
Write-Output "With -Confirm"
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm -Confirm

Write-Output `n`n'Setting $ConfirmPreference to High'
$ConfirmPreference = "High"

Write-Output "`n`nWithout"
