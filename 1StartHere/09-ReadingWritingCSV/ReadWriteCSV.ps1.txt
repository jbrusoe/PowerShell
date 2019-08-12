#Import-Csv & Export-Csv Demonstration
#Written by: Jeff Brusoe
#Last Updated: July 3, 2018

Write-Output "Generating a CSV File: ReadWriteCSV.csv"

Get-Service | where {$_.Status -eq "Running"} | Export-CSV ReadWriteCSV.csv -Force #-Force overwrites the file if it already exists

Write-Output "CSV file generated"

Write-Output "`nReading CSV File: ReadWriteCSV.csv"

$Services = Import-Csv "ReadWriteCSV.csv"

foreach ($Service in $Services)
{
	Write-Output $Service.Name
}
