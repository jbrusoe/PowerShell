#PowerShell - if/then demo

#Note: Read-Host is saved as a string. The [int] forces it
#it to become an integer variable instead. What happens if a
#letter is put in place instead? How could you correct for that?
[int]$Number1 = Read-Host "Enter a number"
[int]$Number2 = Read-Host "Enter another number"

if ($Number1 -eq $Number2)
{
	Write-Output "The two numbers are equal."
}
elseif ($Number1 -gt $Number2)
{
	Write-Output "$Number1 is greater than $Number2"
}
else
{
	Write-Output "$Number2 is greater than $Number1"
}