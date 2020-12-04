#Reverse Word
#PowerShell string manipulation demo
#Written By: Jeff Brusoe
#Last Updated: June 24, 2018

[string]$ReversedWord = $null
[int]$i = 0

$OriginalWord = Read-Host "Enter a word"

Write-Output "Method 1: Using loop and .NET string methods"
Write-Output "Original Word: $OriginalWord`n"

while ($i -lt $OriginalWord.Length)
{
	$ReversedWord = $ReversedWord + $OriginalWord[$OriginalWord.Length - 1-$i]
	
	$i++
	
	Write-Output "Change $i - $ReversedWord"
}

Write-Output "`nReversed Word: $ReversedWord`n"

Write-Output "`n`nMethod 2: Using .net System.Array methods"
Write-Output "Original Word: $ReversedWord"

$CharArray = $ReversedWord.toCharArray()

[array]::Reverse($CharArray)

$OriginalWord = -join($CharArray)
Write-Output "`nReversed Word: $OriginalWord"