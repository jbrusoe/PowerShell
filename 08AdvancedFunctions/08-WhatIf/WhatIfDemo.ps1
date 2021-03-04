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

Write-Output "`n`nWith -WhatIf"
Test-WhatIfConfirm -WhatIf

Write-Output "`n`nWithout -WhatIf"
Test-WhatIfConfirm

Write-Output "`n`nWith -Confirm"
Test-WhatIfConfirm -Confirm
