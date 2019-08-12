#Circle Calculations
#Filename: Circle.ps1
#Version: 1.0
#Language: PowerShell
#
#Written By: Jeff Brusoe
#Date: February 2, 2015
#Email: jbrusoe@gmail.com
#
#The purpose of this program is to take the radius of a circle and 
#calculate the circle's area and circumference. It was written as a demonstration
#program for a Programming merit badge class to show ways to do output, input, if/then, and loop statements.
#
#Some possible changes to this program include the following.  
#These are only suggestions, and many other things can be changed.
#
#1.  Calculate the circle's diameter and display it.
#
#2.  Prevent certain numbers from being entered as a radius.  
#For example, don't allow the radius to be above 30 cm.
#
#3.  Ensure a standardized format for number output.


#Variable initialization
#This may not always be necessary, but is a good programming practice to include it.
[double]$Radius = 0.0
[double]$Circumference = 0.0
[double]$Area = 0.0

Set-Variable -name pi -value 3.14 -option constant

while ($Radius -le 0)
{
	#The purpose of the while loop is to ensure that
	#the radius is valid(greater than 0, not a letter, etc.)
	
	try
	{
		$Radius = Read-Host "Enter the radius in cm"
		
		#This code block detects potential errors that a user may enter.
		if ([string]::IsNullOrEmpty($Radius))
		{
			#This is the case where the user just hit the enter key.
			Write-Host "The radius must be assigned a value." -foregroundcolor Yellow
		}
		elseif ($Radius -le 0)
		{
			#The radius must be positive.
			Write-Host "The radius must be greater than zero." -foregroundcolor Yellow
		}
	}
	catch
	{
		#This should only be executed if a nonnumeric values are entered for the radius.
		Write-Host "The radius can't contain nonnumeric entries." -foregroundcolor Yellow
		$Radius = 0.0
	}
	
}

#At this point, the radius should have a positive value.
Write-Host "`n`nResults" -foregroundcolor Green
Write-Host "*************" -foregroundcolor Green

Write-Host "Radius: $Radius" -foregroundcolor Green

$Circumference = 2*$pi*$Radius
Write-Host "Circumference: $Circumference cm" -foregroundcolor Green

$Area = $pi*$Radius*$Radius
Write-Host "Area: $Area sq cm" -foregroundcolor Green