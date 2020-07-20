function Get-JBProcessInfo
{
	<#
		.SYNOPSIS
			This function displays basic information about processes that are passed into it.
			
		.PARAMETER ProcessNames
			This parameter accepts a string (array) of a process name()s to get information about. 
		
		.PARAMETER Processes
			This parameter accepts a process object (or array of process objects) to get information about them.
			
		.NOTES
			Written by: Jeff Brusoe	
			Last Updated: July 19, 2020
	#>
	
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline=$true,
			ParameterSetName="StringArray",
			Mandatory=$true,
			Position=0)]
		[string[]]$ProcessNames,
		
		[Parameter(ValueFromPipeline=$true,
			ParameterSetName="ProcessArray",
			Mandatory=$true,
			Position=0)]
		[System.Diagnostics.Process[]]$Processes
	)
	
	begin
	{
		Write-Verbose "Beginning to loop through processes"
	}
	
	process
	{
		Write-Host  $("Parameter Set Name: " + $PSCmdlet.ParameterSetName) -ForegroundColor Green
		
		if ($PSCmdlet.ParameterSetName -eq "StringArray")
		{	
			foreach ($ProcessName in $ProcessNames)
			{
				try
				{
					Get-Process $ProcessName -ErrorAction Stop | Select Name,Id,MachineName
				}
				catch
				{
					Write-Warning "Unable to find $ProcessName"
				}
			}
		}
		else
		{
			foreach ($Process in $Processes)
			{
				$Process | Select Name,Id,MachineName
			}
		}
	}

	end
	{
		Write-Verbose "Finished..."
	}
}

<#
Write-Output "Passing String Array into Function"
Write-Output 'Function Call: Get-JBProcessInfo "sqlbrowser","sqlservr" '
Get-JBProcessInfo "sqlbrowser","sqlservr"
#>

Write-Output "`n`nPassing Process Objects into Function"
Write-Output 'Generating Process Objects: Get-Process | Where {$_.Name -like "*sql*"}'
$Processes = Get-Process | Where {$_.Name -like "*sql*"}

Write-Output 'Function Call: Get-JBProcessInfo $Processes'
Get-JBProcessInfo $Processes