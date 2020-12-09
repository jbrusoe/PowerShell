#Derivative Demo
#Written by: Jeff Brusoe
#Last Upated: August 20, 2019

Write-Output "Find the slope of the tangent line of f(x) = 2x^4-5x^2+3 at x = 3"
Write-Output "The actual answer is df/dx = 8x^3-10x = 186.`n"

#This loop simulates the lim DeltaX -> 0
for ($Deltax = 0.1; $Deltax -gt 0; $Deltax = $Deltax - 0.00001)
{
	$Deltax = [math]::round($Deltax,5)
	#Write-Output "Delta x: $Deltax"
	
	$FunctionValue = (2*[math]::Pow(3 + $Deltax,4))-(5*[math]::Pow(3 + $Deltax,2)) + 3
	$FunctionValue -= (2*[math]::Pow(3,4))-(5*[math]::Pow(3,2)) + 3
	$FunctionValue = $FunctionValue/$Deltax
	Write-Output "Derivative Value (Delta x = $Deltax): $FunctionValue"
}