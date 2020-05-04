#Problem 1: 
Set-Location -Path HKCU:\software\microsoft\Windows\CurrentVersion\Explorer\Advanced\
Get-Item .
#At this point, you'd use Set-Item. I don't have this key and don't want to just randomly change registry settings either.

#Problem 2: Create a new directory called C:\Labs.
mkdir c:\labs

#Problem 3: Create a zero-length file named C:\Labs\Test.txt (use New-Item).
New-Item -path C:\Labs\Test.txt -Type file

#Problem 4: Is it possible to use Set-Item to change the contents of C:\Labs\Test.txt to TESTING? Or do you get an error? If you get an error, why?
#set-item : Provider operation stopped because the provider does not support this operation.

#Problem 5: Using the Environment provider, display the value of the system environment variable %TEMP%.
dir env:temp

#Problem 6: 
