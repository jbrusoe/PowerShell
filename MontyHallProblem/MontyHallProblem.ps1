#Monty Hall Problem Demo in PoweShell (converted from code I wrote in Python)
#More information - https://www.youtube.com/watch?v=4Lb-6rxZxx0
#
#Written by: Jeff Brusoe
#Last Updated - August 16, 2019

[int]$Trials = -1

while ($Trials -le 0)
{
	#The purpose of the while loop is to ensure that
	#the number of trials is valid(greater than 0, not a letter, etc.)
	
	try
	{
		$Trials = Read-Host "Number of trials: "
		
		#This code block detects potential errors that a user may enter.
		if ([string]::IsNullOrEmpty($Trials))
		{
			#This is the case where the user just hit the enter key.
			Write-Host "The number of trials must be assigned a value." -foregroundcolor Yellow
		}
		elseif ($Trials -le 0)
		{
			#The radius must be positive.
			Write-Host "The radius must be greater than zero." -foregroundcolor Yellow
		}
	}
	catch
	{
		#This should only be executed if a nonnumeric values are entered for the number of trials.
		Write-Host "The number of trials can't contain nonnumeric entries." -foregroundcolor Yellow
		$Trials = 0.0
	}
	
}

<#
GuessedDoor = 1 #Note: Guessed door will always be door one. This doesn't change the outcome.
CorrectCount = 0
SwitchedCorrectCount = 0

#First set of runs - without switching
for i in range (1,Trials+1):
    GuessedDoor = 1
    print ("Trial " + str(i))

    #Randomly determine the correct door
    CorrectDoor = random.randrange(1,4)
    print ("Correct Door: " + str(CorrectDoor))
    
    if GuessedDoor == CorrectDoor:
        print ("Correct - No switch required")
        CorrectCount += 1
        BlockedDoor = random.randrange(2,4)
        if BlockedDoor == 2:
            GuessedDoor = 3
        else:
            GuessedDoor = 2
    else:
        print ("Incorrect without switch")

        if CorrectDoor == 2:
            BlockedDoor = 3
            GuessedDoor = 2
        else:
            BlockedDoor = 2
            GuessedDoor = 3

    #With switching

    print("Switched Door: ", GuessedDoor)

    if GuessedDoor == CorrectDoor:
        SwitchedCorrectCount += 1
        print ("Switched Correct")
    else:
        print ("Switched Incorrect")

    print ("***********************")

print ("Summary Information:")
print("Total number of trials: ", Trials,"\n")

print ("Correct Count - No Switch: ", str(CorrectCount))
NoSwitchRatio = CorrectCount/(Trials)
print ("No switch ratio: ", str(NoSwitchRatio),"\n")

print ("Correct Count - With Switch: ", str(SwitchedCorrectCount))
SwitchedRatio = SwitchedCorrectCount/(Trials)
print ("Switched Ratio: ", str(SwitchedRatio))
#>