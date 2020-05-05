#1. Identify a cmdlet that produces a random number.
Get-Random

#2. Identify a cmdlet that displays the current date and time.
Get-Date

#3. What type of object does the cmdlet from task 2 produce?
#System.DateTime
Get-Date | Get-Member

#4. Using the cmdlet from task 2 and Select-Object, display only the current day of the week.
Get-Date | Select DayOfWeek

#5. Identify a cmdlet that displays information about installed hotfixes on Windows systems.
Get-Command *Hotfix*
Get-Hotfix

#6. Using the cmdlet from task 5, display a list of installed hotfixes. Then extend the
#expression to sort the list by the installation date, and display only the installation date, 
#the user who installed the hotfix, and the hotfix ID.
Get-Hotfix
Get-Hotfix | Sort InstalledOn -Desc
Get-Hotfix | Sort InstalledOn -Desc | Select InstalledOn,InstalledBy,HotFixId

#7. Repeat task 6, but this time sort the results by the hotfix description, and
#include the description, the hotfix ID, and the installation date. Put the results
#into an HTML file.
Get-Hotfix | Sort Description | Select HotfixID,Description,InstalledOn | ConvertTo-HTML  | Out-File HotfixInfo.html

#8. Display a list of the 50 newest entries from the Security event log. Sort
#the list with the oldest entries appearing first, and with entries made at the same
#time sorted by their index. Display the index, time, and source for each entry.
#Put this information into a text file.
Get-EventLog -LogName System -Newest 50 | Sort -Desc TimeGenerated,Index | Select Index,TimeGenerated,Source | Out-File Security.txt
