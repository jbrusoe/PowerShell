#MergeSort

Set-StrictMode -Version Latest

#Generate an array of random numbers
[int[]]$ArrayToSort = @(0)*50

Write-Output "Original Array"

for ($i = 0; $i -lt 50; $i++)
{
	$NewRandomNumber = Get-Random -Minimum 1 -Maximum 1001
	
	if (($i+1)%10 -eq 0)
	{
		Write-Host $NewRandomNumber
	}
	else
	{
		Write-Host "$NewRandomNumber`t" -NoNewLine
	}
	
	$ArrayToSort[$i] = $NewRandomNumber
}

Write-Output `n"**********************************"

#Array has been generated at this point

function MergeSort([object[]] $SortInput)
{
	# The base case exits for minimal lists that are sorted by definition
	if ($SortInput.Length -le 1) {return $SortInput}
 
	# Divide and conquer
	[int] $midPoint = $SortInput.Length/2
	# The @() operators ensure a single result remains typed as an array
	[object[]] $left = @(MergeSort @($SortInput[0..($midPoint-1)]))
	[object[]] $right = @(MergeSort @($SortInput[$midPoint..($SortInput.Length-1)]))
 
	# Merge
	[object[]] $result = @()
	while (($left.Length -gt 0) -and ($right.Length -gt 0))
	{
		if ($left[0] -lt $right[0])
		{
			$result += $left[0]
			# Use an if/else rather than accessing the array range as $array[1..0]
			if ($left.Length -gt 1){$left = $left[1..$($left.Length-1)]}
			else {$left = @()}
		}
		else
		{
			$result += $right[0]
			# Without the if/else, $array[1..0] would return the whole array when $array.Length == 1
			if ($right.Length -gt 1){$right = $right[1..$($right.Length-1)]}
			else {$right = @()}
		}
	}
 
	# If we get here, either $left or $right is an empty array (or both are empty!).  Since the
	# rest of the unmerged array is already sorted, we can simply string together what we have.
	# This line outputs the concatenated result.  An explicit 'return' statement is not needed.
	$result + $left + $right
}

MergeSort -SortInput $ArrayToSort
