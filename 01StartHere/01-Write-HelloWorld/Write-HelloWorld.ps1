#PowerShell "Hello World" demonstration
#
#Written by: Jeff Brusoe
#Date: June 17, 2017
#
#There are many ways to write output in PowerShell, and
#a few different ways are shown here.
#Some are better than others and depend on the situation.

Write-Output "Method 1: Just using quotes -`"Hello World!`""
"Hello World!`n"

#OR

Write-Output "Method 2: Using Write-Host"
Write-Host "Hello World!`n"

#OR

Write-Output "Method 3: Using Write-Host with -ForegroundColor paramter"
Write-Host "Hello World!`n" -ForegroundColor Cyan

#OR

Write-Output "Method 4: Using Write-Output"
Write-Output "Hello World!`n"

#OR

Write-Output "Method 5: Using the echo alias"
echo "Hello World!`n"

#OR
Write-Output "Method 6: Using the Write alias"
Write "Hello World!`n"

#OR
Write-Output "Method 7: Using Write-Warning"
Write-Warning "Hello World!`n"

#OR

Write-Output "Method 8: Using Write-Verbose"
Write-Verbose "Hello World!`n" -Verbose

#OR

Write-Output "Method 9: Using Write-Debug"
Write-Debug "Hello World!`n" -Debug

#OR

Write-Output "Method 10: Using Write-Information"
Write-Information "Hello World`n" -InformationAction Continue