#TrigFunctionDemo.ps1
#Written by: Jeff Brusoe
#
#Demo of trig functions. It shows how to use common math functions in PowerShell.
#Version 1 doesn't use Format-Table. Version 2 is implemented with PS object
#and Format-Table.

Set-Variable -Name "pi" -Value ([Math]::PI) -Option Constant

Write-Output "Pi: $pi"

$Results = @()

for ($degree = 0; $degree -lt 360; $degree++)
{
	$Trig = New-Object -TypeName PSObject
	
	$Trig | Add-Member -MemberType NoteProperty -Name "Theta(Degrees)" -Value $degree
	
	$sin = [math]::sin($degree*$pi/180)
	$sin = [math]::Round($sin,4)
	
	$Trig | Add-Member -MemberType NoteProperty -Name "Sin(thteta)" -Value $sin
	
	$sinsquared = $sin*$sin
	$sinsquared = [math]::Round($sinsquared,4)
	
	$Trig | Add-Member -MemberType NoteProperty -Name "Sin^2" -Value $sinsquared
	
	$cos = [math]::cos($degree*$pi/180)
	$cos = [math]::Round($cos,4)
	
	$Trig | Add-Member -MemberType NoteProperty -Name "Cos(theta)" -Value $cos
	
	$cossquared = $cos*$cos
	$cossquared = [math]::Round($cossquared,4)
	
	$Trig | Add-Member -MemberType NoteProperty -Name "Cos^2" -Value $cossquared
	
	$sum = $sinsquared + $cossquared
	$sum = [math]::Round($sum)
	
	$Trig | Add-Member -MemberType NoteProperty -Name "Sum" -Value $sum
	
	$Results += $Trig
}

$Results | Format-Table