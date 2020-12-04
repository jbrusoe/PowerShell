#Demonstration of PSObject

Clear-Host

$PhysicsBook = New-Object -TypeName PSObject
$PhysicsBook | Add-Member -MemberType NoteProperty -Name "BookName" -Value "Intro Physics"
$PhysicsBook | Add-Member -MemberType NoteProperty -Name "Author" -Value "Halliday & Resnick"
$PhysicsBook | Add-Member -MemberType ScriptMethod -Name "GetBookInfo" -Value {"Title: " + $this.BookName + "`nAuthor: " + $this.Author}

Write-Output `n'$PhysicsBook Object'
$PhysicsBook

Write-Output "`nCalling GetBookInfo method"
$PhysicsBook.GetBookInfo()

Write-Output "`nCalling objects individually"
Write-Output $("Title: " + $PhysicsBook.BookName)
Write-Output $("Author: " + $PhysicsBook.Author)