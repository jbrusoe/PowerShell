#Note: dir, gci, and Get-ChildItem can all be used here.

dir env:

Write-Output "`n`nNow pulling computer name"

gci env:\ComputerName | Out-Host