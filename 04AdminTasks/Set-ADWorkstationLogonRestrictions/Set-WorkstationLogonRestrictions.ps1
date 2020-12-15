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

foreach ($user in $users)
{
	"Current User: " + $user.samaccountname
	"Workstation to be added: " + $user.workstation

	$LDAPFilter = "(SamAccountName=" + $user.samaccountname + ")"
	
	$usr = get-aduser -LDAPFilter $LDAPFilter -properties userWorkstations
	
	if ($usr -ne $null)
	{
		Write-Output $("User DN: " + $usr.DistinguishedName)
		
		$Workstations = $usr.userWorkstations
		
		$NewWorkstationArray = @($user.workstation)
		
		foreach ($Workstation in $Workstations)
		{
			"Current workstations: " + $Workstation
			
			if ($NewWorkstationArray -contains $Workstation)
			{
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
	else
	{
		Write-Output $("User not found: " + $user.samaccountname)
	}
	
	"`n*************************************`n"
	
}