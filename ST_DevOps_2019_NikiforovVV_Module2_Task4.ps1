#1.	Вывести список всех классов WMI на локальном компьютере. 
Get-WmiObject -list 

#2.	Получить список всех пространств имён классов WMI. 
Get-WmiObject -namespace root -list 

#3.	Получить список классов работы с принтером.
Get-WmiObject -list *print*  

#4.	Вывести информацию об операционной системе, не менее 10 полей.
Get-WmiObject -Class win32_operatingSystem | ForEach-Object{ Write-host $_.SystemDirectory; $_.BuildNumber; $_.SerialNumber; $_.Version; $_.SystemDrive; $_.Status; $_.LocalDateTime; $_.WindowsDirectory; $_.TotalVirtualMemorySize; $_.TotalVisibleMemorySize} 

#5.	Получить информацию о BIOS.
Get-WmiObject -Class Win32_BIOS 

#6.	Вывести свободное место на локальных дисках. На каждом и сумму.
$SumFreeSpace = 0
Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object {Write-Host $_.Name ([math]::Round(($_.Freespace / 1Gb),2)); $SumFreeSpace += [math]::Round(($_.Freespace / 1Gb),2)}
Write-Host 'Total free space:' $SumFreeSpace 'Gb'

#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
$SumPing = 0
for($i = 1; $i -le 4; $i++)
{
$Ping = Get-WmiObject win32_PingStatus -Filter "Address = '192.168.0.1'"
Write-host 'Ожидание ответа' $Ping.ResponseTime 'ms' ;
$SumPing += $Ping.ResponseTime
}
Write-Host 'Сумма пингов на ХОСТ -' $SumPing 'ms' 

#8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
Get-WmiObject -Class Win32_Product | Format-Table Name, Version 

#9.	Выводить сообщение при каждом запуске приложения MS Word.
register-wmiEvent -query "select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='winword.exe'" -sourceIdentifier "ProcessStarted" -Action { Write-Host "RUNNING" }