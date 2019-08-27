#Demonstration of PSObject

$Book = New-Object -typename PSObject
$Book | Add-Member -MemberType NoteProperty -Name "BookName" -Value "Intro Physics"
$Book | Add-Member -MemberType NoteProperty -Name "Author" -Value "Halliday & Resnick"
$Book | Add-Member -MemberType ScriptMethod -Name "GetBookInfo" -Value {"Title: " + $this.BookName + "`nAuthor: " + $this.Author}

$Book

Write-Output "`nCalling GetBookInfo method"
$Book.GetBookInfo()

Write-Output "`nCalling objects individually"
Write-Output $("Title: " + $Book.BookName)
Write-Output $("Author: " + $Book.Author)


