#Monty Hall Problem Demo in PoweShell (converted from code I wrote in Python)
#More information - https://www.youtube.com/watch?v=4Lb-6rxZxx0
#
#Written by: Jeff Brusoe
#Last Updated - August 16, 2019

[string]$Trials = $null

#This block of code is used to get a valid number of trials.
while ([string]::IsNullOrEmpty($Trials))
{
	#The purpose of the while loop is to ensure that
	#the number of trials is valid(greater than 0, not a letter, etc.)
	
	try
	{
		$Trials = Read-Host "Number of trials"
		
		#This code block detects potential errors that a user may enter.
		if ([string]::IsNullOrEmpty($Trials))
		{
			#This is the case where the user just hit the enter key.
			Write-Warning "The number of trials must be assigned a value."
		}
		elseif ([int]$Trials -le 0)
		{
			#The radius must be positive.
			Write-Warning "The number of trials must be greater than zero."
			$Trials = $null
		}
		else
		{
			Write-Output $("Number of trials: " + [int]$Trials)
		}
	}
	catch
	{
		#This should only be executed if a nonnumeric values are entered for the number of trials.
		Write-Warning "The number of trials can't contain nonnumeric entries."
		$Trials = $null
	}
}

$GuessedDoor = 1 #Note: Guessed door will always be door one. This doesn't change the outcome.
$CorrectCount = 0
$SwitchedCorrectCount = 0

#First set of runs - without switching
for ($i = 1; $i -le [int]$Trials; $i++)
{
	$GuessedDoor = 1
    
	Write-Output "Trial: $i"
	
	#Randomly determine the correct door
	$CorrectDoor = Get-Random -Minimum 1 -Maximum 4
	Write-Output "Correct Door: $CorrectDoor"
	
	#With switching
	if ($GuessedDoor -eq $CorrectDoor)
	{
		Write-Output "Correct - No switch required"
		
		$CorrectCount++
		$BlockedDoor = Get-Random -Minimum 2 -Maximum 4
		
		if ($BlockedDoor -eq 2)
		{
			$GuessedDoor = 3 
		}
		else
		{
			$GuessedDoor = 2
		}
	}
	else
	{
		Write-Output "Incorrect without switch"
		
		if ($CorrectDoor -eq 2)
		{
			$BlockedDoor = 3
			$GuessedDoor = 2
		}
		else
		{
			$BlockedDoor = 2
			$GuessedDoor = 3
		}
	}
	
	Write-Output "Switched Door: $GuessedDoor"
	
	if ($GuessedDoor -eq $CorrectDoor)
	{
		$SwitchedCorrectCount++
		Write-Output "Switched Correct"
	}
	else
	{
		Write-Output "Switched Incorrect"
	}
	
	Write-Output "********************************"
}
    
Write-Output "Correct Count - No Switch: $CorrectCount"
$NoSwitchRatio = $CorrectCount/$Trials
Write-Output "No switch ratio: $NoSwitchRatio"

Write-Output "Correct Count - With Switch: $SwitchedCorrectCount"
$SwitchedRatio = $SwitchedCorrectCount/(Trials)
print ("Switched Ratio: ", str(SwitchedRatio))
#>

Write-Output "Summary Information"
Write-Output $("Total number of trials: " + [int]$Trials)