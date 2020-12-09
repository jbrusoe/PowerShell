#Vocab Practice
cls

$Qs = @()
$InteractiveMode = $false
$MultipleChoice = $true
$MultipleChoiceContinuousMode = $false
$Delay = 3
$NumberOfQuestions = 20
$GenerateWordReport = $true

$WordsToSkip = @()

. .\VocabList.ps1

remove-item "WordsUsed.txt" -ea "SilentlyContinue"

if ($GenerateWordReport)
{
	remove-item "WordReport.txt" -ea "SilentlyContinue"
	
	for ($i=0;$i -lt $Qs.Length; $i++)
	{
		$Definition = $Qs[$i].substring($Qs[$i].indexof(":")+1).Trim()
		$Word = $Qs[$i].substring(0,$Qs[$i].indexof(":")).Trim()
		
		Add-Content "WordReport.txt" $("Word: " + $Word)
		Add-Content "WordReport.txt" $("Definition: " + $Definition)
		Add-Content "WordReport.txt" "`n*******************************`n"
	}
}


#Begin to ask questions
while ($true)
{
		#MultipleChoiceContinuousMode $true - correct answer is given and no user input
	
		$j = @()
		$Maximum = $Qs.Length - 1

		while ($true)
		{
			$j = get-random -InputObject (0..$Maximum) -Count 5
			if ($WordsToSkip -NotContains $j[0])
			{
				break
			}
			else
			{
				#$WordsToSkip | sort-object
			}
		}
		
		#Position to put correct answer in
		$k = get-random -Maximum 5 -Minimum 0

		$Q = $Qs[$j[0]]
		$A = $Q
		
		Add-Content "WordsUsed.txt" $Q
		
		
		$Q = $Q.substring($Q.indexof(":")+1).Trim()
		Write-Host -ForegroundColor Green $Q
		
		$A = $A.substring(0,$A.indexof(":")).Trim()
		if ($MultipleChoiceContinuousMode)
		{
			Write-Host -ForegroundColor Yellow $A
		}
		
		$m = $j[0]
		$n = $j[$k]
		
		$j[$k] = $m
		$j[0] = $n
		
		$Count = 0
		$Prefix = "A. ","B. ","C. ","D. ","E. "
		
		
		
		if (!$MultipleChoiceContinuousMode)
		{
			#$A - Debug code
			#Prompt for user answer
			$j | foreach {
				$Choice = $Qs[$_].substring(0,$Qs[$_].indexof(":")).Trim()
				echo $($Prefix[$Count] + $Choice)
				if ($Choice -eq $A)
				{
					$CorrectLetter = $Prefix[$Count]
					$CorrectLetter = $CorrectLetter -Replace ". " ,""
					$CorrectLetter = $CorrectLetter.Trim()
				}
				$Count++
			}
			echo "`n"
			
			$CanContinue = $False
			$FirstTry = $true
			
			while (!$CanContinue)
			{
				$Answer = Read-Host "Answer"

				#echo $CorrectLetter
				#echo $Answer
				
				if ($CorrectLetter.toLower() -eq $Answer.Trim().toLower())
				{
					Write-Host -ForegroundColor Green "Correct!"
					$CanContinue = $true
					
					if ($FirstTry)
					{
						$WordsToSkip += $m
					}
					
					
				}
				else
				{
					Write-Host -ForegroundColor Red "Try again!"
					
				}
			}
		}
		
		echo "`n****************************`n"
		
		if ($WordsToSkip.Length -eq $Qs.Length)
		{
			break
		}

}