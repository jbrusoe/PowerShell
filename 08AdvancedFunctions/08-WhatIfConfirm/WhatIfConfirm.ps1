#Demo of -WhatIf parameter
#Written by: Jeff Brusoe
#Last Updated: January 11, 2021

function Test-WhatIfConfirm
{
	[CmdletBinding(SupportsShouldProcess=$true,
					ConfirmImpact='Medium')]
	param()
	
	if ($PSCmdlet.ShouldProcess("Running Get Service")) {
		Get-Service | Select-Object -First 3
	}
}

Write-Output "`n`nWithout -WhatIf"
Write-Output "Without -Confirm"
Test-WhatIfConfirm

Write-Output "`n***************************`n"

Write-Output "`nWith -WhatIf"
Write-Output "Without -Confirm"
Test-WhatIfConfirm -WhatIf

Write-Output "`n***************************`n"

Write-Output "`nWithout -WhatIf"
Write-Output "Without -Confirm"
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm | Format-Table

Write-Output "`n***************************`n"

Write-Output "`nWithout -WhatIf"
Write-Output "With -Confirm"
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm -Confirm | Format-Table

Write-Output "`n***************************`n"

Write-Output `n'Setting $ConfirmPreference to Medium'
$ConfirmPreference = "Medium"

Write-Output "`nWithout -WhatIf"
Write-Output "Without Confirm"
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm | Format-Table

Write-Output "`n***************************`n"

Write-Output "`nWithout -WhatIf"
Write-Output 'With -Confirm:$false'
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm -Confirm:$false | Format-Table
