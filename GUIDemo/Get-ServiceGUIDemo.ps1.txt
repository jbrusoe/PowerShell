#Note: For help to get started with PowerShell GUIs, go to poshgui.org.
#Also, if you decide to build a form in PowerShell, you should first ask if there
#is a better way to design and code a form with something like C# or another language.

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$PSGUIDemo = New-Object system.Windows.Forms.Form
$PSGUIDemo.ClientSize = '544,750'
$PSGUIDemo.text = "PowreShell Get-Service GUI Demo"
$PSGUIDemo.TopMost = $false

$btnGetService = New-Object system.Windows.Forms.Button
$btnGetService.text = "Get-Service"
$btnGetService.width = 94
$btnGetService.height = 30
$btnGetService.location = New-Object System.Drawing.Point(20,710)
$btnGetService.Font = 'Microsoft Sans Serif,10'

$dgvService = New-Object system.Windows.Forms.DataGridView
$dgvService.width = 473
$dgvService.height = 675
$dgvService.location = New-Object System.Drawing.Point(20,17)
$dgvService.ColumnCount = 3
$dgvService.ColumnHeadersVisible = $true
$dgvService.Columns[0].Name = "Name"
$dgvService.Columns[1].Name = "Status"
$dgvService.Columns[2].Name = "DisplayName"
$dgvService.Columns[2].Width = 230

$PSGUIDemo.controls.AddRange(@($btnGetService,$dgvService))

$btnGetService.Add_Click({ Get-Service | foreach{ $dgvService.Rows.Add($_.Name,$_.Status,$_.DisplayName)}})

[void]$PSGUIDemo.ShowDialog()