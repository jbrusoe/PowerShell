#PowerShell Number Guessing Game
#Written by: Jeff Brusoe
#Last Updated: March 10, 2021

$ActualNumber = Get-Random -Minimum 1 -Maximum 101
$NumberGuessed = $false
$GuessCount = 0

while (!$NumberGuessed)
{
	try {
		[int]$UserGuess = Read-Host -Prompt "Guess number between 1 and 100" -ErrorAction Stop

		if (($UserGuess -lt 1) -OR ($UserGuess -gt 100)) {
			throw "Invalid number input"
		}
	}
	catch {
		Write-Warning "Please enter a valid integer between 1 and 100"
		continue
	}

	$GuessCount++
	Write-Output "`nNumber of Guesses: $GuessCount`n"

	if ($UserGuess -eq $ActualNumber) {
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