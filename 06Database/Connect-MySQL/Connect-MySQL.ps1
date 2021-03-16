#Connect-MySQL.ps1
#Written by: Jeff Brusoe
#Last Updated: March 15, 2021
#
#Purpose: This file is intended to connect to MySQL with MS PowerShell.

$MySQLHost = "localhost"
$User="Jeff"
$Password = "PowerShellMySQL"
$Database = "co2db"

[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")

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