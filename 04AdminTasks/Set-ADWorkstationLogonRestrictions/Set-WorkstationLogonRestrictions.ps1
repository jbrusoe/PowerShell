#Set-WorkstationLogonRestriction
#Written by: Jeff Brusoe
#Last Updated: December 14, 2020
#
#The purpose of this file is to set up restrictions on AD users
#so that they can only log into certain workstations.

[CmdletBindging()]
param (
	[ValidateNotNullOrEmpty()]
	[string]$WorkstationMapping = "$PSScriptRoot\UserWorkstationInfo.csv"
)

try {
	Write-Verbose "Configuring Environment"

	Import-Module ActiveDirectory -ErrorAction Stop
	$WorkstationMappings = Import-Csv $WorkstationMapping -ErrorAction Stop
}
catch {
	Write-Warning "Unable to configure environment. Program is exiting"
	exit
}

foreach ($WorkstationMapping in $WorkstationMappings)
{
	Write-Output $("Current User: " + $WorkstationMapping.SamAccountName)
	Write-Output $("Workstation to be added: " + $WorkstationMapping.workstation)

	$LDAPFilter = "(SamAccountName=" + $WorkstationMapping.samaccountname + ")"
	Write-Verbose "LDAP Filter: $LDAPFilter"

	$GetADUserParams = @{
		LDAPFilter = $LDAPFilter
		Properties = "userWorkstations"
		ErrorAction = "Stop"
	}
	try {
		$ADUser = Get-ADUser @GetADUserParams
	}
	catch {
		Write-Warning "Unable to get AD user object"
		$ADUser = $null
	}

	if ($null -ne $ADUser)
	{
		Write-Output $("User DN: " + $ADUser.DistinguishedName)

		$Workstations = $ADUser.userWorkstations

		$NewWorkstationArray = @($ADUser.workstation)

		foreach ($Workstation in $Workstations)
		{
			"Current workstations: " + $Workstation

			if ($NewWorkstationArray -contains $Workstation) {
				Write-Output "Workstation already in restrictions list"
			}
			else
			{
				Write-Output "Adding workstation to users restriction list"

				$NewWorkstationArray += $Workstation

				$usr | set-aduser -LogonWorkstations ($NewWorkstationArray -join ",")
			}
		}
	}
	else {
		Write-Output $("User not found: " + $ADUser.samaccountname)
	}

	"`n*************************************`n"
}