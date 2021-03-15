#Connect-ToMySQL.ps1
#Written by: Jeff Brusoe
#
#Purpose: This file is intended to connect to MySQL with MS PowerShell.

[void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data")

[string]$MySQLHost = "localhost"
[string]$User="Jeff"
[string]$Password = "PowerShellMySQL"
[string]$Database = "co2db"

$ConnStr = "server=" + $MySQLHost + ";uid=" + $User + ";pwd=" + $Password + ";database=" + $Database + ";"
Write-Output "Connection String: $connStr"

$MySQLConn = New-Object MySql.Data.MySqlClient.MySqlConnection($ConnStr)
$MySqlConn.Open()

$query = "select * from co2data;"

$cmd = $MySQLConn.CreateCommand() 
$cmd.CommandText = $query 

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