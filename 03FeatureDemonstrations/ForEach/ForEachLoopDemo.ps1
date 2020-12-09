$Numbers = 1..10

Write-Output "Number`tNumber*6"
Write-Output "======`t========"

foreach ($Number in $Numbers)
{
	Write-Output $("$Number`t" + $Number*6)
}