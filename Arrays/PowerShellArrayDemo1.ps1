Clear-Host #Note: cls is also an alias for this.

Write-Output "Creating Array 1"
Write-Output "Code to create array: `$a = 1,2,3,4,5,6,7,8,9,10"
$a = 1,2,3,4,5,6,7,8,9,10

Write-Output "`n`$a.GetType()"
$a.GetType()

Write-Output "`nArray 1 Count"
Write-Output "`$a.Length"
$a.Length

Write-Output "`nArray 1 Elements"
Write-Output "`$a"
$a

Write-Output "`nAdding an element to Array 1"
Write-Output "`$a += 11,12,13"
$a += 11,12,13

Write-Output "`nArray 1 New Count"
$a.Length

Write-Output "`nArray 1 New Elements"
$a