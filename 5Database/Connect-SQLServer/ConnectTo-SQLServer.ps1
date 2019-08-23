#ConnectToSQLServer-PowerShell.ps1
#Written by: Jeff Brusoe
#
#This file is a demonstration of using PowerShell to connect to a Microsoft SQL Server.

$conn = New-Object System.Data.SqlClient.SqlConnection

$ConnectionString = "Server=tcp:MyServer.database.windows.net;Database=TestDatabase;"
$ConnectionString += "User ID=TestDBLogin;Password=MyGreatPassword!;Trusted_Connection=False;Encrypt=True;"

$conn.ConnectionString = $ConnectionString
$conn.open()

$cmd = $conn.CreateCommand()

$cmd.commandtext = "SELECT * FROM [dbo].[CO2];"

$reader = $cmd.ExecuteReader()

[bool]$PrintColumnTitles = $true

while ($reader.Read()) 
{
	if ($PrintColumnTitles)
	{
		for ([int]$Column = 0; $Column -lt $reader.FieldCount; $Column++)
		{
			Write-Host $($reader.GetName($Column) + "`t") -ForeGroundColor Green -NoNewLine
		}

		Write-Host ""
		$PrintColumnTitles = $false;
	}
	
	for ($i= 0; $i -lt $reader.FieldCount; $i++) 
	{
		Write-Host $($reader.GetValue($i).ToString() + "`t") -NoNewLine
	}
	
	Write-Host ""
}

