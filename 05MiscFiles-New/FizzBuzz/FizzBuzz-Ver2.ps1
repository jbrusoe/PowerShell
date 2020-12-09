#PowerShell FizzBuzz Implementation - Version 2

for ($i = 1; $i -lt 101; $i++)
{	
	if (($i%3 -eq 0) -AND ($i%5 -eq 0)) {
		Write-Output "$i - FizzBuzz"
	}
	elseif ($i%3 -eq 0) {
		Write-Output "$i - Fizz"
	}
	elseif ($i%5 -eq 0) {
		Write-Output "$i - Buzz"
	}
	else {
		Write-Output $i
	}
	
}