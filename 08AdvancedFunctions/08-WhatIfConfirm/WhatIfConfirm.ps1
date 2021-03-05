#Demo of -WhatIf and -Confirm Parameters
#Written by: Jeff Brusoe
#Last Updated: March 4, 2021

function Test-WhatIfConfirm
{
	[CmdletBinding(SupportsShouldProcess=$true,
					ConfirmImpact='Medium')]
	param()
	
	if ($PSCmdlet.ShouldProcess("Running Get Service")) {
		Get-Service | Select-Object -First 3
	}
}

$ConfirmPreference = "High"

Write-Output "`n`nWithout -WhatIf"
Write-Output "Without -Confirm"
Test-WhatIfConfirm

Write-Output "`n***************************`n"

Write-Output "With -WhatIf"
Write-Output "Without -Confirm"
Test-WhatIfConfirm -WhatIf

Write-Output "`n***************************`n"

Write-Output "Without -WhatIf"
Write-Output "Without -Confirm"
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm | Format-Table

Write-Output "`n***************************`n"

Write-Output "Without -WhatIf"
Write-Output "With -Confirm"
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm -Confirm | Format-Table

Write-Output "`n***************************`n"

Write-Output 'Setting $ConfirmPreference to Medium'
$ConfirmPreference = "Medium"

Write-Output "`nWithout -WhatIf"
Write-Output "Without Confirm"
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm | Format-Table

Write-Output "`n***************************`n"

Write-Output "Without -WhatIf"
Write-Output 'With -Confirm:$false'
Write-Output "ConfirmPreference: $ConfirmPreference"
Write-Output "ConfirmImpact: Medium"
Test-WhatIfConfirm -Confirm:$false | Format-Table
