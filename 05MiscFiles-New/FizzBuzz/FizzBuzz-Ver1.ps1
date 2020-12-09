#PowerShell FizzBuzz Implementation - Version 1

for ($i = 1; $i -lt 101; $i++)
{
	$MultOf3 = $false
	$MultOf5 = $false
	
	if ($i%3 -eq 0) {
		$MultOf3 = $true
	}
	
	if ($i%5 -eq 0) {
		$MultOf5 = $true
	}
	
	if ($MultOf3 -AND $MultOf5) {
		Write-Output "$i - FizzBuzz"
	}
	elseif ($MultOf3) {
		Write-Output "$i - Fizz"
	}
	elseif ($MultOf5) {
		Write-Output "$i - Buzz"
	}
	else {
		Write-Output $i
	}
	
}