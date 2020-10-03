function Copy-DirectoryBasedOnCSV
{
	[CmdletBinding()]
	param (
		[ValidateNotNull()]
		[string]$SourceDir = "$PSScriptRoot\Source\",

		[ValidateNotNull()]
		[string]$DestinationDir = "$PSScriptRoot\Destination\",

		[ValidateNotNull()]
		[string]$CSVDirectoryList = "$PSScriptRoot\CSVList.csv"
	)

	$InitialErrorCount = $Error.Count
	
	Write-Output "Beginning function to copy directory structure" | Out-Host
	
	Write-Output "Source Directory: $SourceDir"
	if (Test-Path $SourceDir) {
		Write-Output "Source Directory Exists" | Out-Host
	}
	else {
		Write-Warning "Source directory doesn't exist"
		return "SourceDirectoryError"
	}
	
	Write-Output "Destination Directory: $DestinationDir"
	if (Test-Path $DestinationDir) {
		Write-Output "Destination directory Exists" | Out-Host
	}
	else {
		Write-Warning "Destination directory doesn't exist"
		return "DestinationDirectoryError"
	}
	
	Write-Output "CSV Directory List: $CSVDirectoryList" | Out-Host
	if (Test-Path $DestinationDir) {
		Write-Output "CSV directory list exists" | Out-Host
	}
	else {
		Write-Warning "CSV directory list doesn't exist"
		return "CSVDirectoryListError"
	}
	
	try {
		$CSVDirectories = Get-Content $CSVDirectoryList -ErrorAction Stop

		Write-Output "CSV Directories from file:" | Out-Host
		Write-Output $CSVDirectories | Out-Host
		Write-Output "`n`n" | Out-Host
	}
	catch {
		Write-Warning "Unable to open CSV File"
		return "UnableToOpenCSV"		
	}
	
	#Begin processing directories
	foreach ($CSVDirectory in $CSVDirectories)
	{
		Write-Output "Current CSV Directory: $CSVDirectory" | Out-Host

		$DestinationDirectories = Get-ChildItem $DestinationDir
		
		$MatchingDirectories = $DestinationDirectories | where {$_.Name -like "*$CSVDirectory*"}
		
		if ($null -ne $MatchingDirectories)
		{
			Write-Output "Directory Match Found" | Out-Host
			$LastDirectory = $MatchingDirectories | sort LastWriteTime -desc | select -First 1
			
			Write-Output $("Last Directory: " + $LastDirectory.Name) | Out-Host

			try {
				$LastDirectoryBaseName = $LastDirectory.Name.substring(0,$LastDirectory.Name.LastIndexOf("-"))
				$LastChar = $LastDirectory.Name.substring($LastDirectory.Name.LastIndexOf("-") + 1)

				$LastChar = $LastChar.toInt32($null)
				$LastChar++
				$LastChar = $LastChar.toString()

				$DirectoryNameToCopy = $LastDirectoryBaseName + "-" + $LastChar
			}
			catch {
				$Error.Clear()
				$DirectoryNameToCopy = $LastDirectory.Name + "-1"
			}
		}
		else {
			#No corresponding directory found
			$DirectoryNameToCopy = $CSVDirectory
		}

		Write-Output "Directory Name to Copy: $DirectoryNameToCopy" | Out-Host

		Write-Output "Copying Directory" | Out-Host
		
		try {
			Copy-Item "$SourceDir\$CSVDirectory" -Destination "$DestinationDir\$DirectoryNameToCopy" -Recurse
		}
		catch {
			Write-Warning "Error copying directory"
		}

		Write-Output "********************************" | Out-Host
	}
	
	if ($InitialErrorCount -eq $Error.Count)
	{
		return "SUCCESS"
	}
	else
	{
		return $("CopyFinishedWith" + $Error.Count + "Errors")
	}
}

$Error.Clear()
Clear-Host
$CSVArchiveDirectory = "$PSScriptRoot\ArchivedCSV\"

$TranscriptLogFile = (Get-Date -Format yyyy-MM-dd-HH-mm) + "-MoveDirectoryTranscript.txt"
Start-Transcript $TranscriptLogFile

Copy-DirectoryBasedOnCSV

Write-Output "CSV Archive Directory: $CSVArchiveDirectory"
if (Test-Path $CSVArchiveDirectory) {
	Write-Output "CSV archive directory exists"
	
	try {
		Move-Item -Path "$PSScriptRoot\*.csv" -Destination $CSVArchiveDirectory -Force -ErrorAction Stop
		Write-Output "Successfully moved CSV to archive directory"
	}
	catch {
		Write-Warning "Unable to move CSV to archive directory"
	}
}
else {
	Write-Warning "CSV archive directory doesn't exist. Unable to move file"
}
	


Stop-Transcript