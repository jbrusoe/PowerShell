#PowerShell for loop demonstration

Write-Output "For loop from 1 to 10"
for($i=1;$i -le 10; $i++) {
	Write-Output "Current Number: $i"
}

Write-Output "`nFor loop from 10 to 1"
for ($i=10;$i -gt 0; $i--) {
	Write-Output "Current Number: $i"
}

Write-Output "`nFor loop from 1 to 20 counting by 2"
for ($i=2; $i -le 20; $i += 2) {
	Write-Output "Current Number: $i"
}