#Demonstration of math functions in PowerShell
#Relies on System.math .NET class
#https://docs.microsoft.com/en-us/dotnet/api/system.math?view=netframework-4.8
#
#Written by: Jeff Brusoe
#Last Updated: May 8, 2019

#[float] forces the variables to become floating point numbers instead of strings (Read-Host default return type)
[float]$FirstNumber = Read-Host "Enter the first number"
[float]$SecondNumber = Read-Host "Enter a second number"

Write-Output $("$FirstNumber + $SecondNumber = " + $([float]$FirstNumber+[float]$SecondNumber))
Write-Output $("$FirstNumber - $SecondNumber = " + $([float]$FirstNumber-[float]$SecondNumber))
Write-Output $("$FirstNumber * $SecondNumber = " + $([float]$FirstNumber*[float]$SecondNumber))

if ($SecondNumber -eq 0)
{
	Write-Warning "Second number is 0. Unable to perform division operation"
}
else
{
	Write-Output $("$FirstNumber/$SecondNumber = " + $([math]::Round([float]$FirstNumber/[float]$SecondNumber,2)))
}

Write-Output "`nFirstNumber: $FirstNumber"
Write-Output $("Absolute Value: " + [math]::abs($FirstNumber))

if ($FirstNumber -lt 0)
{
	Write-Warning "You have entered a negative number. Unable to calculate its square root, log base 10, and natural logarithm"
}
elseif ($FirstNumber -eq 0)
{
	Write-Warning "You have entered 0. Unable to calculate log base 10 and natural logarithm"
	Write-Output $("Square Root: " + [math]::Round([math]::sqrt($FirstNumber),2))
}
else
{
	Write-Host "You have entered a positive number. Calculating square root, log base 10, and natural logarithm" -ForegroundColor Green
	Write-Output $("Square Root: " + [math]::Round([math]::sqrt($FirstNumber),2))
	Write-Output $("Log10: " + [math]::Round([math]::log10($FirstNumber)),2)
	Write-Output $("Natural Log: " + [math]::Round([math]::log($FirstNumber),2))
}