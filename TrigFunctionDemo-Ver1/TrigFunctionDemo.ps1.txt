#TrigFunctionDemo.ps1
#Written by: Jeff Brusoe
#
#Demo of trig functions. It shows how to use common math functions in PowerShell.
#Version 1 doesn't use Format-Table. See Version 2 for implementation wtih Format-Table.
Set-Variable -Name "pi" -Value ([Math]::PI) -Option Constant

Write-Output "Pi: $pi"

Write-Output "theta(Degrees)`tsin(theta)`tsin^2(theta)`tcos(theta)`tcos^2(theta)`tSum"
Write-Output "==============`t==========`t============`t==========`t============`t==="

for ($degree = 0; $degree -lt 360 ; $degree++)
{
		$sin = [math]::sin($degree*$pi/180)
		$sin = [math]::Round($sin,4)
		
		$sinsquared = $sin*$sin
		$sinsquared = [math]::Round($sinsquared,4)
		
		$cos = [math]::cos($degree*$pi/180)
		$cos = [math]::Round($cos,4)
		
		$cossquared = $cos*$cos
		$cossquared = [math]::Round($cossquared,4)
		
		$sum = $sinsquared + $cossquared
		$sum = [math]::Round($sum)
		
		Write-Output "$degree`t`t$sin`t`t$sinsquared`t`t$cos`t`t$cossquared`t`t$sum"
}