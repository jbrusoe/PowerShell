<#
.SYNOPSIS
Backup-Files.ps1
Written By: Jeff Brusoe (jbrusoe@gmail.com)
Originally Written: October 1, 2017
Last Updated: June 16, 2019

The purpose of this file is to backup (both incremental and full) files from my laptop to my Google Drive directory to be
synced and backed up to the cloud. It is obviously highly customized to my own environment, but can be modified fairly easily.
It runs on scheduled tasks at various intervals.

.DESCRIPTION
This file is designed to copy data from my laptop to the TempBackupHolding directory (C:\Users\jbrus\Google Drive\Documents\TempBackupHolding).
Doing this will ensure that the backups are copied up to the cloud via Google Backup and Sync. After they are copied there,
they can then be moved to the final backup location which isn't synced to protect against malware and ransomware.

It currently runs as a scheduled task to do an incremental backup every 15 minutes and full backup once per day.

.PARAMETER FullBackup
This parameter is used to do a full backup of the specified directories. The default is to do an incremental backup.

.PARAMETER IncludeVideos
Using this parameter implies that videos will be backed up in a full backup. They will automatically be backed up in incremental backups.

.PARAMETER Zotero
This is a parameter I use to only do backups on my Zotero directory (C:\Users\jbrus\Zotero).
It is mostly used when I run the backups manually after I've made a lot of changes to it. 

.PARAMETER CodeSamples
This is a parameter I use to only do backups on my code samples directory(C:\Users\jbrus\Google Drive\Documents\ProgrammingMeritBadge\CodeSamples).
This directory was originally created to hold samples of code for the Programming Merit Badge class that I teach. 
In addition to this, I also store files here that I want to refer to later on.

.PARAMETER Delay
My home internet is terribly slow with upload speeds, and uploading any files causes download speeds to plummet. I built this parameter 
in because of that. It simply backs up the first 250 files and then will pause. The length of the pause is 2 minutes by default but can be
configured with the $DelaySeconds parameter.

.PARAMETER RemoveZeroByteFiles
This parameter removes any zero byte files that were backed up. This is done to prevent a cosmetic error
when uploading files to OneDrive.

.PARAMETER DelaySeconds
This parameter specifies the number of seconds to wait if the $Delay parameter is used.

.PARAMETER BackupDirectory
The location of the directory to copy the files being backed up to.

.PARAMETER DirectoryList
To be implemented. The purpose of this parameter is to read in a CSV file containing the directory
names to be backed up instead of having to edit this code to modify the backup directories.

.EXAMPLE
Backup-Files
This will do an incremental backup on all directories specified in the $DirectoriesToBackup array.

.EXAMPLE
Backup-Files -FullBackup
Full backup on all directories speified in the $DirectoriesToBackup array.

.EXAMPLE
Backup-Files -FullBack -CodeSamples
Does a full backup on the codesamples directory (C:\Users\jbrus\Google Drive\Documents\ProgrammingMeritBadge\CodeSamples).

#>

[CmdletBinding()]
param (
	[switch]$FullBackup, #specifies full or incremental backups. Incremental is default.
	[switch]$IncludeVideos, #Switch to include videos in full backup
	[switch]$Delay, #Delays are due to issues with my home internet.
	[switch]$RemoveZeroByteFiles, #Prevents a cosmetic error when uploading files to OneDrive.
	[int]$DelaySeconds = 120,
	[string]$BackupDirectory = "C:\Users\jbrus\Google Drive\Documents\TempBackupHolding\",	#This is where the files being backed up are copied to.
	[string]$DirectoryList = $null, #To be implemented
	
	#Parameters to indicate backups of only specific directories
	[switch]$Zotero,
	[switch]$CodeSamples,
	[switch]$MachineLearning,
	[switch]$NuclearScience,
	[switch]$SpaceExploration,
	[switch]$Robotics,
	[switch]$Astronomy,
	[switch]$Orienteering,
	[switch]$FLL,
	[switch]$MARS,
	[switch]$GitHub,
	[switch]$MARSGitHub,
	[switch]$LabVIEW,
	[switch]$AllPowerShell #Backs up all PoweShell files instead of just ps1
	#[switch]$Anaconda3
	)

#####################################################
#Initialize variables and configure environment
#####################################################

#Change window title
$Host.UI.RawUI.WindowTitle = "Backup-Files.ps1"

Clear-Host

Set-StrictMode -Version Latest

$MinimumFreeSpaceGB = 15
$global:ChangedFiles = 0 #Acts as counter for incremental backups
$Error.Clear()

#The date variables are being stored as a string to ensure consistency with backup file names.
[string]$CurrentDate = Get-Date -format yyyy-MM-dd-HH-mm #Year-Month-Day-Hour-Minute

Start-Transcript $($PSScriptRoot +"\" + "BackupTranscript" + "\" + $CurrentDate + "-BackupTranscript.txt")

#Specify which directories need to be backed up
$DirectoriesToBackup = @()

if ($Zotero -OR $CodeSamples -OR $NuclearScience -OR $Orienteering -OR $MachineLearning -OR $FLL -OR $AllPowerShell -OR $MARS -OR $GitHub -OR $MARSGitHub -OR $LabVIEW)
{
	#These parameters are used to indicate that only a specific directory (or directories) is to be backed up.
	
	if ($Zotero) { $DirectoriesToBackup += "C:\Users\jbrus\Zotero" }
	if ($CodeSamples) { $DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\ProgrammingClasses\CodeSamples" }
	if ($NuclearScience) { $DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\MeritBadges\NuclearScience" }
	if ($Orienteering) { $DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\MeritBadges\Orienteering" }
	if ($MachineLearning) { $DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\ProgrammingClasses\MachineLearning" }
	if ($FLL) { $DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\2018-FLL" }
	if ($AllPowerShell) { $DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\ProgrammingClasses\CodeSamples\PowerShell" }
	if ($MARS) { $DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\MARS" }
	if ($GitHub) { $DirectoriesToBackup += "C:\Users\jbrus\Documents\GitHub" ; $DirectoriesToBackup += "C:\MARSGitHubRepo" }
	if ($MARSGitHub) { $DirectoriesToBackup += "C:\MARSGitHubRepo\MARS-Tucker-Team" ; $DirectoriesToBackup += "C:\Users\jbrus\Documents\GitHub\MARS-2020" }
	if ($LabVIEW) { $DirectoriesToBackup += $DirectoriesToBackup += "C:\Users\jbrus\Documents\GitHub\LabVIEW" }
	
}
else
{
	$DirectoriesToBackup += "C:\Users\jbrus\Documents\GitHub"
	$DirectoriesToBackup += "C:\Users\jbrus\Zotero"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\Research"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\LiteratureReview"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\ProgrammingClasses"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\MeritBadges\NuclearScience"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\MeritBadges\Orienteering"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\WVUPowerShell"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\2018-FLL"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\DissertationWork"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\PERWork"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\SCFD620"
	$DirectoriesToBackup += "C:\Users\jbrus\Google Drive\Documents\MARS"
}

Write-Output "`nDirectories being backed up:"
$DirectoriesToBackup

if ($FullBackup)
{
	Write-Output "Backup Type: Full"
}
else
{
	Write-Output "Backup Type: Incremental"
}

#####################################################
#End of initialization and configuration section
#####################################################

#####################################################
#Function Code Block
#####################################################
Function Full-Backup
{
	#Purpose: This function is used to make a full backup of the
	#$DirectoryToBackup that is passed into the function.
    [CmdletBinding()]
    param (
		[string]$BackupDirectory = $null,
		[string]$DirectoryToBackup = $null
		)

	Write-Output "In Full-Backup Function"
	Write-Output "Include Videos: $IncludeVideos"
	
	if ($IncludeVideos)
	{
		$ExcludeArray = $null
	}
	else
	{
		$ExcludeArray = "*.mp4","*.mov","*.flv","*.avi","*.wmv"
	}
	
	if ([string]::IsNullOrEmpty($DirectoryToBackup) -OR [string]::IsNullOrEmpty($BackupDirectory))
	{
		Write-Warning "An input parameter is null which is not allowed. This backup will not be done."
	}
	else
	{
		"Backup Directory: " + $BackupDirectory
		
		Set-Location $BackupDirectory

		Write-Verbose $("Setting location to " + $BackupDirectory)
		Set-Location $BackupDirectory

		Write-Host "Beginning full backup" -ForeGroundColor Green
		
		#Get-ChildItem $DirectoryToBackup -Recurse -Exclude $ExcludeArray | Copy-Item  -Destination {Join-Path $BackupDirectory $_.FullName.Substring($DirectoryToBackup.length)} -Verbose
		
		$ChildItems = Get-ChildItem $DirectoryToBackup -Recurse -Exclude $ExcludeArray
		
		$Count = 0
		foreach ($ChildItem in $ChildItems)
		{
			"Full File Name: " + $ChildItem.FullName
			
			$FileName = $ChildItem.FullName
			
			$Destination = Join-Path $BackupDirectory $FileName.Substring($DirectoryToBackup.length)
			Copy-Item -LiteralPath $FileName -Destination $Destination -Verbose
			
			$Count++
			"File Count: $Count"
			
			if (($Delay) -AND ($Count % 250 -eq 0))
			{
				Write-Output "Beginning delay..."
				
				ForEach ($SecondsCount in (1..$DelaySeconds))
				{   
					Write-Progress -Id 1 -Activity "Built in delay..." -Status "Waiting for $DelaySeconds seconds, $($DelaySeconds - $SecondsCount) left" -PercentComplete (($SecondsCount / $DelaySeconds) * 100)
					Start-Sleep -Seconds 1
				}

				Write-Progress -Id 1 -Activity "Delay finished..." -Status "Completed" -PercentComplete 100 -Completed
			}
			
			if ($Error.Count -gt 0)
			{
				#This was used for testing purposes.
				#"Error - Program is exiting"
				#Return
			}	
		}
	}
	
	$global:ChangedFiles += $Count
	Return
}

Function Incremental-Backup
{
    [CmdletBinding()]
	param (
		[string]$BackupDirectory = $null,
		[string]$DirectoryToBackup = $null
		)
	
	if ([string]::IsNullOrEmpty($DirectoryToBackup) -OR [string]::IsNullOrEmpty($BackupDirectory))
	{
		Write-Warning "An input parameter is null which is not allowed. This backup will not be done."
	}
	else
	{
		Write-Output "`nIn incremental backup function"

		Set-Location $BackupDirectory
		
		#Looks at any files changed in the last 90 minutes.
		#Also, AddMinutes is a .NET call not something built into PowerShell.
		$Files = Get-ChildItem $DirectoryToBackup -Recurse -File | where {$_.LastWriteTime -gt (Get-Date).AddMinutes(-90)}
		[int]$TotalFiles = 0
			
		if (($Files | Measure-Object).Count -gt 0)
		{
			foreach ($File in $Files)
			{
				if ($File.FullName.indexOf("BackupTranscript.txt") -gt 0)
				{
					Write-Output $("Skipping: " + $File.FullName)
				}
				else
				{
					Write-Output $("`nCopying File: " + $File.FullName)
					Write-Output $("Last Write Time: " + $File.LastWriteTime)
					
					$TotalFiles++
					
					$File | Copy-Item -Destination $BackupDirectory -Verbose -Recurse -Container
				}
			}
		}
		else
		{
			Write-Output "No files to backup"
		}
		
		$global:ChangedFiles += $TotalFiles
	}
	
	Return ,$TotalFiles #Output returned as an array because of how PowerShell deals with return statements. Last element in array is what I care about.
}

#####################################################
#End of function code block
#####################################################

#####################################################
#Main program
#####################################################

Write-Output "`nBeginning backups"
#This is done as a check to make sure that there is enough free space to write the backups.
$FreeSpace = (Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace
$FreeSpace = [math]::Floor($FreeSpace/1GB)

Write-Output "`nDrive Freespace: $FreeSpace GB"

[string]$BackupDirectoryRoot = $BackupDirectory
$BackupDirectoryRoot = $BackupDirectoryRoot + "\$CurrentDate-Incremental-Backups"
Write-Output "BackupDirectoryRoot: $BackupDirectoryRoot"

if ($FreeSpace -gt $MinimumFreeSpaceGB)
{
    Write-Output "There is enough drive free space for backups.`n"

	for ($i = 0; $i -lt $DirectoriesToBackup.Length; $i++)
	{
		Write-Output $("Current Directory: " + $DirectoriesToBackup[$i])
		
		if (Test-Path $DirectoriesToBackup[$i])
        {
            Write-Verbose "Directory exists and will be backed up"

            if (!$FullBackup)
            {
                #Perform incremental backup
                Write-Host "Performing incremental backup" -ForegroundColor Green
	
                #Create the diretory where file being backed up are copied to.
	            #$BackupDirectory = "$BackupDirectory\$CurrentDate-Incremental-Backups"

                $DirectoryToBeBackedUp = $DirectoriesToBackup[$i].substring($DirectoriesToBackup[$i].LastIndexOf("\")+1)
                Write-Host $("`nBegining backup for: " + $DirectoryToBeBackedup) -ForegroundColor Green
	            
                $BackupDirectory = $BackupDirectoryRoot + "\" + $DirectoryToBeBackedUp

                Write-Output "Backups saved to directory: $BackupDirectory"

	            if (!(Test-Path $BackupDirectory))
	            {
		            "Creating Backup Directory"
		            mkdir $BackupDirectory | Out-Null
	            }

	            [int]$FilesChanged = (Incremental-Backup -BackupDirectory $BackupDirectory -DirectoryToBackup $DirectoriesToBackup[$i])[-1]
	
	            Set-Location $PSScriptRoot
	
	            if ($FilesChanged -eq 0)
	            {
		            Write-Output "`nNo files were backed up. Removing backup directory."
		
		            Remove-Item -Path $BackupDirectory -Force
	            }
	            else
	            {
		            Write-Output "`nTotal Files Changed in this Directory: $FilesChanged"
	            }

            }
            else
            {
                #Full backup
				Write-Host "Performing full backup" -ForegroundColor Green
		
				$FullBackupDirectory = $BackupDirectory + $CurrentDate + "-Full-Backups"

				$DirectoryToBeBackedUp = $DirectoriesToBackup[$i].substring($DirectoriesToBackup[$i].LastIndexOf("\")+1)
                Write-Host $("`nBegining full backup for: " + $DirectoryToBeBackedup) -ForegroundColor Green
				
				$FullBackupDirectory += "\"+ $DirectoryToBeBackedUp
				
				"Backup Directory: " + $FullBackupDirectory

				if (!(Test-Path $FullBackupDirectory))
				{
					Write-Output "Creating Backup Directory"
					mkdir $FullBackupDirectory | Out-Null
				}

				Set-Location $FullBackupDirectory

				Full-Backup -BackupDirectory $FullBackupDirectory -DirectoryToBackup $DirectoriesToBackup[$i]
				
				Set-Location $PSScriptRoot #"C:\Users\jbrus\Desktop\"
            }
        }
        else
        {
            Write-Warning "That directory is not currently being synced or doesn't exist."
        }

        if (($DirectoriesToBackup.Length -gt 1) -AND ($i -ne $DirectoriesToBackup.Length -1))
        {
            #Just needed for help with programs's visual output
            "***********************"
        }
	}
}
else
{
	Write-Warning "Drive space is under 20 GB. Backups will not be performed."
}

#Backup has been completed. Cleanup tasks and writing summary information to screen.

Set-Location $PSScriptRoot

Write-Output "***********************"

if ($RemoveZeroByteFiles)
{
	#This is an option which prevents a cosmetic error when backing up to OneDrive.
	$Files = Get-ChildItem $BackupDirectoryRoot -Recurse -File

	if ($Files.Length -eq 0)
	{
		Write-Output "There are no zero byte files to remove."
	}
	else
	{
		Write-Output "Removing zero byte files from backups."
		
		foreach ($File in $Files)
		{
			if ($File.Length -eq 0)
			{
				Write-Output $("Deleting file: " + $File.Fullname)
				Write-Output $("File Size: " + $File.Length)
				
				Remove-Item $File.Fullname
			}    
		}
	}
	
	Write-Output "***********************"
}

if (($global:ChangedFiles -eq 0) -AND (!$FullBackup))
{
	
	Write-Output "No files were changed."
	Write-Output "Removing: $BackupDirectoryRoot"
	
    Remove-Item $BackupDirectoryRoot
}
else
{
	Write-Output $("Total Number of Files Backed Up: " + $global:ChangedFiles)
}

Stop-Transcript

Exit