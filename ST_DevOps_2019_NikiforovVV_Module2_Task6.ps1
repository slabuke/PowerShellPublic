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
Invoke-Command -ScriptBlock {
    IF (-not(TEST-PATH \\vm2\Users\Administrator\Desktop\TESTSHARE)) 
                  {
                    New-Item -Type Directory -Path \\VM2\Users\Administrator\Desktop\TESTSHARE
                  }
    
    $Shares = [WMICLASS]”WIN32_Share”
    $Shares.Create(“\\VM2\Users\Administrator\Desktop\TESTSHARE”,”TEST”,0,24)
    
    } -ComputerName VM2 -Credential Administrator
    <#Invoke-Command -ScriptBlock {
        (Get-WmiObject -List -ComputerName .| Where-Object -FilterScript {$_.Name –eq "Win32_Share"}).InvokeMethod("Create",("C:\M2T2_Nikiforov","TempShare",0,25,"test share of the temp folder"))
        } -ComputerName VM1 -Credential Administrator#>

#1.5.	Удалить шару из п.1.4
Invoke-Command -ScriptBlock {

    Remove-SmbShare -Name "TESTSHARE" -Force
    Remove-Item -Path "\\VM2\Users\Administrator\Desktop\TESTSHARE" -Force
    
} -ComputerName VM1 -Credential Administrator

#1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.
#2.	Работа с Hyper-V
Enable-WindowsOptionalFeature -Online -FeatureName  Microsoft-Hyper-V-Management-PowerShell

Enable-WindowsOptionalFeature -Online -FeatureName  Microsoft-Hyper-V-Tools-All

Enable-WindowsOptionalFeature -Online -FeatureName  Microsoft-Hyper-V-All

#2.1.	Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
Get-Command -CommandType Cmdlet -Source Hyper-V 

#2.2.	Получить список виртуальных машин 
Get-VM

#2.3.	Получить состояние имеющихся виртуальных машин
Enable-VMResourceMetering -VMName Nikiforov-VM1
Measure-VM -VMName Nikiforov-VM1

#2.4.	Выключить виртуальную машину
Stop-VM -Name VM1 -TurnOff -Force

#2.5.	Создать новую виртуальную машину
New-VM -Name VM4

#2.6.	Создать динамический жесткий диск
New-VHD -Path D:\VMS\test\dddisc.vhdx -Dynamic -SizeBytes 20Gb

#2.7.	Удалить созданную виртуальную машину
Remove-VM -Name VM4