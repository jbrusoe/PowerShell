#Demonstration of PowerShell $Error variable
#Last Updated: December 2, 2020

Clear-Host
$Error.Clear()

Write-Output $("Error Count: " + $Error.Count)

Write-Output "Dividing 5 by 0"
5/0

Write-Output $("Error Count: " + $Error.Count)

Write-Output "`nAttempting to get non existent service"
Get-Service "asdfasdf"

Write-Output $("Error Count: " + $Error.Count)

Write-Output `n'Displaying values in $Error:'

Write-Output `n'$Error[0]:'
Write-Output $Error[0]

Write-Output `n'$Error[1]:'
Write-Output $Error[1]

Write-Output "`nClearing error variable"
$Error.Clear()

Write-Output $("Error Count: " + $Error.Count)