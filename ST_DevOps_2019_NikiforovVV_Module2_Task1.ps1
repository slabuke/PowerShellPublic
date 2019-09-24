#1.	Получите справку о командлете справки 
Update-Help                   #В моем случае справка оказалась пустой, поэтому необходимо было ее загрузить
Get-Help Get-Help 

#2.	Пункт 1, но детальную справку, затем только примеры
Get-Help Get-Help -Detailed
Get-Help Get-Help -Examples

#3.	Получите справку о новых возможностях в PowerShell 4.0 (или выше)
Get-help about_Windows_PowerShell_5.0

#4.	Получите все командлеты установки значений
Get-Command -CommandType Cmdlet -Name Set* 

#5.	Получить список команд работы с файлами
Get-Command -Noun Item

#6.	Получить список команд работы с объектами
Get-Command -Noun Object

#7.	Получите список всех псевдонимов
Get-Alias

#8.	Создайте свой псевдоним для любого командлета
Set-Alias -Name data -Value Get-Date
Get-Alias -Name data

#9.	Просмотреть список методов и свойств объекта типа процесс
$d = Get-Process -Name svchost
$d | Get-Member -MemberType Properties, Method

#10.	Просмотреть список методов и свойств объекта типа строка
$string = "My name is Slava"
$string | Get-Member

#11.	Получить список запущенных процессов, данные об определённом процессе
Get-Process
Get-Process -Name explorer 

#12.	Получить список всех сервисов, данные об определённом сервисе
Get-Service
Get-Service -Name Spooler

#13.	Получить список обновлений системы
Get-HotFix #первый вариант
Import-Module PSWindowsUpdate   #второй с добавлением дополнительного модуля
Get-WUHistory

#14.	Узнайте, какой язык установлен для UI Windows
Get-Culture | Format-List -Property *

#15.	Получите текущее время и дату
Get-Date

#16.	Сгенерируйте случайное число (любым способом)
Get-Random -Maximum 10 -Minimum 0 

#17.	Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели.
(Get-Process -Name explorer).StartTime
(Get-Process -Name explorer).StartTime.DayOfWeek 

#18.	Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell
$File = "C:\Users\ASUS\Desktop\word.docx"
$Word = New-Object -ComObject Word.Application
$Word.Visible = $true
$Document = $Word.Documents.Open($File)
$Document.Close()
$Word.Quit()

#19.	Подсчитать значение выражения S= . N – изменяемый параметр. Каждый шаг выводить в виде строки. (Пример: На шаге 2 сумма S равна 9)
$i++ ; $S=$S+3*$i; Write-Output "На шаге $i, сумма будет равна $s"

#20.	Напишите функцию для предыдущего задания. Запустите её на выполнение.
function Summ
 {
     Clear-Host
    $n = Read-Host "Задайте N"
    Do {$i++ ; $S=$S+3*$i ; Write-output "На шаге $i, сумма S равна $S"}
    While ($i -lt $n)  
}