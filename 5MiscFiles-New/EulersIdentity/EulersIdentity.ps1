#This demonstrates making .NET calls in PowerShell by doing math with complex numbers.
#Specifically, this program calculates e^i*pi + 1 which should equal zero. The real
#Component of the solution is zero, and PowerShell calculates the imaginary part to be
#a number on the order of 10^-16 (i.e. A very small number....)

$Euler = [System.Numerics.Complex]::Exp([System.Numerics.Complex]::ImaginaryOne * [System.Math]::pi) + 1

Write-Output $("Real Part of Solution: " + $Euler.Real)
Write-Output $("Imaginary Part of Solution: " + $Euler.Imaginary)