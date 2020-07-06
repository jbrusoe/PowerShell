Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$mainForm = New-Object Windows.Forms.Form
$mainForm.Location = "200,200"
$mainForm.FormBorderStyle = "FixedDialog"
##$mainForm.BackColor = "White"
$mainForm.Text = "Conway's Game of Life"
$mainForm.size = "520,280"

$mainForm.ShowDialog() | Out-Null