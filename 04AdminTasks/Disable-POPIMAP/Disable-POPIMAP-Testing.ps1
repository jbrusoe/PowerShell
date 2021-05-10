#Disable-POPIMAP.ps1
#Public Version
#
#Written by: Jeff Brusoe
#Last Modified: November 16, 2018
#
#This file ensures that POP and IMAP are disabled on all Exchange mailboxes.

Set-StrictMode -Version Latest
$Error.Clear()
$Host.UI.RawUI.WindowTitle = "Disable-POPIMAP.ps1"

$UserNumber = 0

try {
	Write-Output "`nGenerating list of mailboxes..."

	$Mailboxes = Get-CasMailbox -ResultSize Unlimited -ErrorAction Stop|
		Where-Object {($_.IMAPEnabled -eq $true) -OR ($_.POPEnabled -eq $true)}
}
catch {
	Write-Warning "Unable to generate list of mailboxes"
	exit
}


if (($Mailboxes | Measure-Object).Count -eq 0) {
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
		
		try {
			Write-Output "Disabling POP and IMAP"
			Set-CasMailbox -Identity $Mailbox.PrimarySMTPAddress -POPEnabled $false -IMAPEnabled $false -ErrorAction Stop
			Write-Output "POP and IMAP have been disabled."	
		}
		catch {
			Write-Output $("Error Setting " + $Mailbox.PrimarySMTPAddress)
		}
		Finally {
			$Error.Clear()
		}
		Write-Output "***********************"
	}
}