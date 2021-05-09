#Reverse Word - PowerShell string manipulation demo
#Written By: Jeff Brusoe
#Last Updated: June 24, 2018

[string]$ReversedWord = $null

$OriginalWord = Read-Host "Enter a word"

Write-Output "Method 1: Using loop and .NET string methods"
Write-Output "Method 1 Original Word: $OriginalWord`n"

for  ($i = 0; $i -lt $OriginalWord.Length; $i++) {
	$ReversedWord = $ReversedWord + $OriginalWord[$OriginalWord.Length - 1-$i]
	Write-Output "Method 1 Change $i - $ReversedWord"
}

Write-Output "Method 1 Reversed Word: $ReversedWord`n"

Write-Output "`n`nMethod 2: Using .net System.Array methods"
Write-Output "Method 2 Original Word: $ReversedWord"

$CharArray = $ReversedWord.toCharArray()

[array]::Reverse($CharArray)

$OriginalWord = -join($CharArray)
Write-Output "Method 2 Reversed Word: $OriginalWord"