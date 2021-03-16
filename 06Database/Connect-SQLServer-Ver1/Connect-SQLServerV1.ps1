#PowerShell - Connect to SQL Server with Invoke-SQLCmd
#Written by: Jeff Brusoe
#Last Updated: March 15, 2021

$ConnectionString = "Server=MyServerIP;Database=MyDatabase;"
$ConnectionString += "User ID=MyUserID;Password=PowerShellSQLServer;"
$ConnectionString += "Trusted_Connection=False;Encrypt=True;"

$Query = "SELECT * FROM [dbo].[CO2-SQLData];"

Invoke-SqlCmd -ConnectionString $ConnectionString -Query $Query | Format-Table