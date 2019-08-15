#Disable-POPIMAP.ps1
#Public Version
#
#Written by: Jeff Brusoe
#Last Modified: November 16, 2018
#
#This file ensures that POP and IMAP are disabled on all Exchange mailboxes.

[CmdletBinding()]
param (
	#Common PowerShell Parameters
	[switch]$NoSessionTranscript,
    [string]$LogFilePath = $PSScriptRoot + "\Logs",
	[switch]$StopOnError #$true is used for testing purposes
)

###################################
#Configure environment
###################################

#Note: This file assumes that a connection to the cloud has been established.
#If it hasn't been, use the Connect-ToOffice365 (also in the PowerShell-AdminTasks directory) to do this.
Set-StrictMode -Version Latest

$Error.Clear()

if ($StopOnError)
{
	$ErrorActionPreference = "Stop"
}
else
{
	$ErrorActionPrefernce = "Continue"
}

$Host.UI.RawUI.WindowTitle = "Disable-POPIMAP.ps1"

[int]$UserNumber = 0
###################################
#End of configure environment block
###################################

Write-Output "`nGenerating list of mailboxes..."

$Mailboxes = Get-CasMailbox -ResultSize Unlimited | where {($_.IMAPEnabled -eq $true) -OR ($_.POPEnabled -eq $true)}

if (($Mailboxes | Measure-Object).Count -eq 0) #Note: This syntax is used due to the Set-StrictMode cmdlet used above.
{
	Write-Output "POP and IMAP are already disabled on all mailboxes.`n"
}
else
{
	foreach ($Mailbox in $Mailboxes)
	{
		$UserNumber++
		Write-Output "Current user number: $UserNumber"
		Write-Output $("PrimarySMTPAddress: " + $Mailbox.PrimarySMTPAddress)
		Write-Output $("IMAPEnabled: " + (Get-CasMailbox $Mailbox.PrimarySMTPAddress).IMAPEnabled)
		Write-Output $("POPEnabled: " + (Get-CasMailbox $Mailbox.PrimarySMTPAddress).POPEnabled)
		
		try
		{
			Write-Output "Disabling POP and IMAP"
			Set-CasMailbox -Identity $Mailbox.PrimarySMTPAddress -POPEnabled $false -IMAPEnabled $false -ErrorAction Stop
			Write-Output "POP and IMAP have been disabled."	
		}
		catch
		{
			Write-Output $("Error Setting " + $Mailbox.PrimarySMTPAddress)
		}
		Finally
		{
			$Error.Clear()
		}
		Write-Output "***********************"
	}
}

Exit