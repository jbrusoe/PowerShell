cls

import-module activedirectory

$users = import-csv UserWorkstationInfo.csv

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