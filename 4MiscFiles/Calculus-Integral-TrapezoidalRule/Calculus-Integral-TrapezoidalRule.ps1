#Trapezoidal Rule Demonstration
#Written by: Jeff Brusoe
#Last Updated: August 23, 2019

#http://tutorial.math.lamar.edu/Classes/CalcII/ApproximatingDefIntegrals.aspx

$NumberOfIntervals = [int](Read-Host "Number of Intervals")
Write-Output "Intervals: $NumberOfIntervals"

$b = 5
$a = 2
$Deltax = ($b-$a)/$NumberOfIntervals

Write-Output "Delta x: $Deltax"

$Area = 0

for ($i = 0; $i -le $NumberOfIntervals; $i++)
{
	$x = $a + ($i*$Deltax)
	Write-Output "Current Value of X: $x"
	
	if (($x -eq 0) -OR ($x -eq $NumberOfIntervals))
	{
		$Area = $Area + ([math]::Pow($x,4)/8)
	}
	else
	{
		$Area = $Area + ([math]::Pow($x,4)/4)
	}
}

$Area = $Area * $Deltax

Write-Output "Answer from Trapezoidal Rule: $Area"
Write-Output "Actual Answer: 152.25"
Write-Output "Since the second derivative of x^3 is positive, we'd expect the Trapezoidal Rule to overestimate the actual answer."