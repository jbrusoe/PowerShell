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

Write-Output "Using strings as pipeline input"
Write-Output 'Function Call: "sqlbrowser","sqlservr" | Get-JBProcessInfo'
"sqlbrowser","sqlservr" | Get-JBProcessInfo

Write-Output "`n`nUsing process objects as pipeline input"
Write-Output 'Getting Processes: $Processes = Get-Process | where {$_.Name -like "*sql*"}'
$Processes =  Get-Process | where {$_.Name -like "*sql*"}

Write-Output 'Now Get Process Info: $Processes | Get-JBProcessInfo'
$Processes | Get-JBProcessInfo

