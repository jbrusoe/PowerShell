# Collatz Conjecture in PowerShell
# Written By: Jeff Brusoe
# Last Updated: March 7, 2021

<#
From Wikipedia - "The Collatz conjecture is a conjecture in mathematics that concerns a sequence 
defined as follows: start with any positive integer n. Then each term is obtained from the previous
term as follows: if the previous term is even, the next term is one half the previous term. If the
previous term is odd, the next term is 3 times the previous term plus 1.
The conjecture is that no matter what value of n, the sequence will always reach 1."
#>

$Count = 0 #Keeps track of number of steps to get to 1

while ($true) {
	#The purpose of this loop is to ensure that a proper starting value is entered.

	try {
		[ulong]$i = Read-Host "Enter an integer greater than or equal to 1" -ErrorAction Stop
	}
	catch {
		Write-Warning "Please enter a valid starting integer"
		continue
	}

	if ($i -lt 1) {
		Write-Warning "Please enter a valid starting integer"
	}
	else {
		break
	}

}

Write-Output "Original Number: $i"

while (($Count -eq 0) -OR ($i -ne 1))
{
	if ($i%2 -eq 0) {
		#Number is even
		$i = $i/2
	}
	else {
		#Number is odd
		$i = 3*$i + 1
	}
	
	$Count++
	
	Write-Output $("Sequence Term $Count`: $i")
}