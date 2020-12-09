#PowerShell demonstration of $args variable
#Written by: Jeff Brusoe
#Last Updated: October 16, 2018

if ($args.length -eq 0)
{
	Write-Output "No command line input was provided."
}
else
{
	Write-Output "Values stored in the `$args array"

	for ($i = 0; $i -lt $args.length ; $i++)
	{
		Write-Output $("`$args[$i]: " + $args[$i])
	}
}