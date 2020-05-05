#Problem 1: Display a list of running processes
Get-Process

#Problem 2: Display the 100 most recent entries from the Application event log. Don't use Get-WinEvent.
Get-EventLog -LogName Application | Select -First 100

#Problem 3: Display a list of all commands that are of the cmdlet type.
Get-Command -CommandType Cmdlet

#Problem 4: Display a list of all aliases
Get-Alias

#Problem 5: Make a new alias, so you can run np to launch Notepad from a PowerShell prompt.
New-Alias -Name "np" Notepad.exe

#Problem 6: Display a list of services that begin with the letter M
Get-Service m*

#Problem 7: Display a list of all Windows Firewall rules.
Get-NetFirewallRule

#Problem 8: Display a list only of inbound Windows Firewall rules.
Get-NetFirewallRule -Direction Inbound

