#http://tutorial.math.lamar.edu/Classes/CalcII/ApproximatingDefIntegrals.aspx

$NumberOfIntervals = [int](Read-Host "Number of Intervals")
Write-Output "Number of intervals: $NumberOfIntervals"

$b = 5
$a = 2
$Deltax = ($b-$a)/(2*$NumberOfIntervals)

Write-Output "Delta x: $Deltax"

$Area = 0

for ($x = 0; $x -le $NumberOfIntervals; $x++)
{
	if (($x -eq 0) -OR ($x -eq $NumberOfIntervals))
	{
	
	}
	else
	{
	
	}
}