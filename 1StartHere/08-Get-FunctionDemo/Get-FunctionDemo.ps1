#PowerShell function demo
#
#Written by: Jeff Brusoe
#Date: June 6, 2017
#
#This function reads two numbers in and multiples them with a function.
#It is a demo file for the Programming Merit Badge class.

function Multiply
{
	param (
		[float]$a,
		[float]$b
	)
	
	#See the following page for the reason of having Out-Host
	#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_return?view=powershell-7
	Write-Output "In Multiply function" | Out-Host
	
	return $a*$b
}

[float]$FirstNumber = Read-Host "Enter any number"
[float]$SecondNumber = Read-Host "Enter another number"

Write-Output $("$FirstNumber * $SecondNumber = " + (Multiply -a $FirstNumber -b $SecondNumber))