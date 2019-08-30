#PowerShell Classes Demo
#Written by: Jeff Brusoe
#Last Updated: August 29, 2019
#
#Note: Requires Version 5 or greater.
#https://overpoweredshell.com/Introduction-to-PowerShell-Classes/

class Book {
	[string]$Title
	[string]$AuthorFirstName
	[string]$AuthorLastName
	[bool]$Read
	[int]$NumberOfPages
	[bool]$RequiredForClass

	[Guid]hidden $GUID = (New-Guid).Guid

	[void]TestMethod()
	{
		return
	}
	
	[string]GetTitle()
	{
		return $this.Title
	}
}

$MyBook = [Book]::new()
$MyBook
$MyBook.Title = "Rendezvous with Rama"

Write-Output "Piped to Get-Member"
$MyBook | Get-Member -MemberType Properties

Write-Output "Piped to Get-Member with -Force switch"
$MyBook | Get-Member -MemberType Properties -Force

#Note: Guid can be accessed this way even though it is hidden
$MyBook.Guid

Write-Output "Calling test method"
$MyBook.TestMethod()

Write-Output "Calling GetTitle method"
$MyBook.GetTitle()

