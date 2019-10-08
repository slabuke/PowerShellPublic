#1.	При помощи WMI перезагрузить все виртуальные машины.
$Computer = @("VM1","VM2","VM3")
Invoke-Command -ScriptBlock {
    Get-WmiObject Win32_OperatingSystem | Invoke-WmiMethod -Name reboot
} -ComputerName $Computer -Credential Administrator

#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 
Invoke-Command -ScriptBlock {
    Get-WmiObject Win32_Service | Where-Object {$_.State -eq "Running"}
 
} -ComputerName $Computer -Credential Administrator | Format-Table -AutoSize

#3.	Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.
#На VM: 
Enable-PSRemoting
#На Хосте:
Set-Item WSMan:\localhost\Client\TrustedHosts -Value *
Enter-PSSession -ComputerName VM1 -Credential Administrator

#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.
#На VM:
Invoke-Command -ScriptBlock {
    Set-Item WSMan:\localhost\listener\listener*\port -Value 42658

} -ComputerName $Computer -Credential Administrator

#На Хосте:
Enter-PSSession -ComputerName VM1 -Port 42658 -Credential Administrator 


#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.
$Computer = @("VM1","VM2","VM3")
$cred=Get-Credential Administrator
Invoke-Command -ScriptBlock {
    New-PSSessionConfigurationFile -Path Guest.pssc –VisibleCmdlets Get-ChildItem
    Test-PSSessionConfigurationFile .\Guest.pssc
    Register-PSSessionConfiguration -Name Guest -Path .\Guest.pssc -RunAsCredential $cred 
} -ComputerName $Computer -Credential $cred


