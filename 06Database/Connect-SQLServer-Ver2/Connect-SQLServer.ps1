#ConnectToSQLServer-PowerShell.ps1
#Written by: Jeff Brusoe
#Last Updated: March 15, 2021
#
#This file is a demonstration of using PowerShell to connect to a Microsoft SQL Server.

$conn = New-Object System.Data.SqlClient.SqlConnection

$ConnectionString = "Server=tcp:MyServerIP;Database=MyDatabase;"
$ConnectionString += "User ID=MyUserID;Password=PowerShellSQLServer;"
$ConnectionString += "Trusted_Connection=False;Encrypt=True;"

$conn.ConnectionString = $ConnectionString
$conn.open()

$cmd = $conn.CreateCommand()

$cmd.commandtext = "SELECT * FROM [dbo].[CO2-SQLData];"

$reader = $cmd.ExecuteReader()

$Datatable = New-Object System.Data.DataTable
$Datatable.Load($reader)
$Datatable | Format-Table