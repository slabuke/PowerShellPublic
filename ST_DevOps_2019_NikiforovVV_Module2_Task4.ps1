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
#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
#8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
Get-WmiObject -Class Win32_Product | Format-Table Name, Version 

#9.	Выводить сообщение при каждом запуске приложения MS Word.
