#1.	Просмотреть содержимое ветви реeстра HKCU
Get-PSDrive
Set-Location -Path HKCU:\
Get-ChildItem -Force

#2.	Создать, переименовать, удалить каталог на локальном диске
New-Item -ItemType Directory -Path C:\Users\ASUS\Desktop\PShellDirectory
Rename-Item -Path C:\Users\ASUS\Desktop\PShellDirectory -NewName RenamedDirectory
Remove-Item -Path C:\Users\ASUS\Desktop\RenamedDirectory

#3.	Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
New-Item -ItemType Directory -Path C:\M2T2_Nikiforov\
New-PSDrive -Name P -Root C:\M2T2_Nikiforov\ -PSProvider FileSystem
Get-PSDrive

#4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
Get-Service | Where-Object {$_.Status -eq "Running"} |Out-File -FilePath P:\Services.txt
Get-ChildItem -Path P:
Get-Content -Path P:\Services.txt

#5.	Просуммировать все числовые значения переменных текущего сеанса.
$S = 0
Get-Variable | ForEach-Object{if($_.Value -is [int]) {$S += $_.Value} }

#6.	Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process | Sort-Object CPU -Descending | Select-Object -First 6

<#7.	Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, 
разделённые знаком тире, при этом если процесс занимает более 100Mb – выводить информацию красным цветом,
иначе зелёным.#>

$a = 1024*1024 # Информация выводится в байтах для перевода в Мб введена переменная "a"
$b = 0
Get-Process | ForEach-Object{
    if([int]$b = ($_.VirtualMemorySize / $a -ge 100))
        { 
    Write-Host $_.Name, ([int]($_.VirtualMemorySize / $a)) -ForegroundColor Red -Separator " - "   
    }
    else {
        Write-Host $_.Name, ([int]($_.VirtualMemorySize / $a)) -ForegroundColor Green -Separator " - "   
       }
    } 
#8.	Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp
Set-Location C:\Windows
Get-ChildItem | ForEach-Object {
if ($_.Name -notlike ".tmp") {$b += $_.Length / 1024 / 1024}
}
$b

#9.	Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
Set-Location "HKLM:\SOFTWARE\Microsoft"
Get-ChildItem | Export-Csv -Path P:\123.csv

#10.	Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.\
Get-History | Export-Clixml -Path P:\123.xml

#11.	Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.
Import-Clixml -Path P:\123.xml  | ForEach-Object {Write-Host $_.Start, $_.ID, $_.EndExecutionTime, $_.ExecutionStatus, $_.CommandLine} 

#12.	Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
Remove-Item -Path P:\
Remove-PSDrive -Name P