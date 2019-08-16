#Monty Hall Problem Demo in Python
#More information - 
#
#Written by: Jeff Brusoe

import random

while True:
    #This loop ensures that a positive integer value is entered for the number of trials.
    try:
        Trials = int(input("How many trials do you want? "))

        if Trials > 0:
            print ("You have selected " + str(Trials) + " trial runs.")
            break
        else:
            print ("The number of trials must be an integer that is greater than 0.")
    except:
        print ("The number of trials can't have letters in it.")

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


    
        
    
