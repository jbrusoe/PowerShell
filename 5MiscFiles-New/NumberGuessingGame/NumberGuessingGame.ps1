#PowerShell Number Guessing Game

[int]$ActualNumber = Get-Random -minimum 1 -maximum 101
[bool]$NumberGuessed = $false
[int]$GuessCount = 0

while (!$NumberGuessed)
{
	$GuessCount++
	Write-Output "`nNumber of Guesses: $GuessCount`n"
	
	[int]$UserGuess = Read-Host "Guess number between 1 and 100"
	
	if ($UserGuess -eq $ActualNumber)
	{
		#Correct guess
		Write-Host -ForeGroundColor Green "You are correct!"
		
		$NumberGuessed = $true
	}
	elseif ($UserGuess -lt $ActualNumber) {
		Write-Host -ForeGroundColor Yellow "Higher"
	}
	else {
		Write-Host -ForeGroundColor Yellow "Lower"
	}
}