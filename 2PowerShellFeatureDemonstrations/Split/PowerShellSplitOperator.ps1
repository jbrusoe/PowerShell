$PSString = "a,b,c,d,e,f,g,h,i,j"

Write-Output "Starting String: $PSString"

Write-Output "`nVariable Type"
$PSString.GetType()

#Splitting string
Write-Output "`n`nSplitting string"
Write-Output "`$PSSplitString = $PSString -split `",`""

$PSSplitString = $PSString -split ","

Write-Output "`n`$PSSplitString Object Type"
$PSSplitString.GetType()

Write-Output "`nSplit String"
$PSSplitString