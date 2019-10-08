#1.	Для каждого пункта написать и выполнить соответсвующий скрипт автоматизации администрирования:
#1.1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)
Get-NetIPConfiguration -Detailed | Select-Object -Property IPv4Address, InterfaceDescription

#1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.
$Comp = @("VM1","VM2","VM3")
Invoke-Command -ScriptBlock {
     $PCName = $env:COMPUTERNAME
     Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE | ForEach-Object {
     Write-Host $PCName `t $_.Description `t $_.IPAddress `t $_.MACAddress
         }
    } -ComputerName $Comp -Credential Administrator
    Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE | ForEach-Object { 
        Write-Host 'Description:' $_.Description -ForegroundColor Red -NoNewline `t;
        Write-Host 'IPAddress:' $_.IPAddress -ForegroundColor Cyan -NoNewline `t;
        Write-Host 'MACAddress:' $_.MACAddress -ForegroundColor Yellow 
    }

#1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.
$Comp = @("VM1","VM2","VM3")
Invoke-Command -ScriptBlock {
$NICs = Get-WMIObject Win32_NetworkAdapterConfiguration | where{$_.IPEnabled -eq “TRUE”}
Foreach($NIC in $NICs) {
     $NIC.EnableDHCP()    
     $NIC.SetDNSServerSearchOrder()    
}
IPConfig /all
    } -ComputerName $Comp -Credential Administrator


#1.4.	Расшарить папку на компьютере
#1.5.	Удалить шару из п.1.4
#1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.
#2.	Работа с Hyper-V
#2.1.	Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
#2.2.	Получить список виртуальных машин 
#2.3.	Получить состояние имеющихся виртуальных машин
#2.4.	Выключить виртуальную машину
#2.5.	Создать новую виртуальную машину
#2.6.	Создать динамический жесткий диск
#2.7.	Удалить созданную виртуальную машину
