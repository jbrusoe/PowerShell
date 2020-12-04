# Collatz Conjecture Demo in PowerShell
# Written By: Jeff Brusoe
# Last Updated: December 3, 2020

<#
From Wikipedia - "The Collatz conjecture is a conjecture in mathematics that concerns a sequence 
defined as follows: start with any positive integer n. Then each term is obtained from the previous
term as follows: if the previous term is even, the next term is one half the previous term. If the 
previous term is odd, the next term is 3 times the previous term plus 1. 
The conjecture is that no matter what value of n, the sequence will always reach 1."
#>

[int]$Count = 0 #Keeps track of number of steps to get to 1
[long]$i = Read-Host "Enter an integer greater than 1"

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