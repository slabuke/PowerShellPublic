$t = New-JobTrigger -Once -At 9:00 -RepetitionInterval 00:10 -RepetitionDuration 10:00
$cred = Get-Credential Администратор
Register-ScheduledJob -Name Script_3 -FilePath D:\Scenario\Script_3.ps1 -Trigger $t -Credential $cred -RunAs32