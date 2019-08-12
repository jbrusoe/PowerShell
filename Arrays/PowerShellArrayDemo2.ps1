#Populate array with output from another cmdlet demo

Clear-Host #Note: cls is also an alias for this.

Write-Output "Creating Array 2"
Write-Output "Code to create array:`n`$b = @()`n`$b=Get-Process"
$b = @()
$b = Get-Process

Write-Output "`n`$b.GetType()"
$b.GetType()

Write-Output "`nArray 2 Count"
Write-Output "`$b.Length"
$b.Length

Write-Output "`nArray 2 Elements"
Write-Output "`$b"
$b | Format-Table