#Note: Where-Object has two aliases: where and ?

Write-Output "`nNo Alias`n"
Get-Service | Where-Object {$_.Status -eq "Running"}

#OR

Start-Sleep -s 10

Write-Output "`nwhere Alias`n"
Get-Service | where {$_.Status -eq "Running"}

#OR

Start-Sleep -s 10

Write-Output "`n? Alias`n"
Get-Service | ? {$_.Status -eq "Running"}