#FizzBuzz

for ($i = 1; $i -lt 101; $i++)
{	
	if (($i%3 -eq 0) -AND ($i%5 -eq 0))
	{
		"$i - FizzBuzz"
	}
	elseif ($i%3 -eq 0)
	{
		"$i - Fizz"
	}
	elseif ($i%5 -eq 0)
	{
		"$i - Buzz"
	}
	else
	{
		$i
	}
	
}