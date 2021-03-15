#Connect-MySQL.ps1
#Written by: Jeff Brusoe
#Last Updated: March 15, 2021
#
#Purpose: This file is intended to connect to MySQL with MS PowerShell.

[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")

[string]$MySQLHost = "localhost"
[string]$User="Jeff"
[string]$Password = "PowerShellMySQL"
[string]$Database = "co2db"

$ConnStr = "server=" + $MySQLHost +
            ";uid=" + $User +
            ";pwd=" + $Password +
            ";database=" + $Database + ";"

Write-Output "Connection String: $connStr"

$MySQLConn = New-Object MySql.Data.MySqlClient.MySqlConnection($ConnStr)
$MySqlConn.Open()

$query = "select * from co2data;"

$cmd = $MySQLConn.CreateCommand() 
$cmd.CommandText = $query 

$reader = $cmd.ExecuteReader()

$Datatable = New-Object System.Data.DataTable
$Datatable.Load($reader)
$Datatable | Format-Table