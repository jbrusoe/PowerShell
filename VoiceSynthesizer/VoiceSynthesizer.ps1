#PowerShell Voice Synthesizer Demo
#Written by: Jeff Brusoe
#Last Updated: May 7, 2019

Add-Type -AssemblyName System.Speech

$talk = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer

foreach ($Voice in $talk.GetInstalledVoices())
{
	$VoiceInfo = $Voice.VoiceInfo
	Write-Output $("Voice Name: " + $VoiceInfo.Name)
	Write-Output $("Voice Gender: " + $VoiceInfo.Gender)
	Write-Output $("Voice Age: " + $VoiceInfo.Age)
	Write-Output $("Voice Culture: " + $VoiceInfo.Culture)
	Write-Output $("Voice Description: " + $VoiceInfo.Description)
	
	$talk.SelectVoice($VoiceInfo.Name)
	$talk.Speak("Open the pod bay doors HAL")
	
	Write-Output "**************************************"
}
