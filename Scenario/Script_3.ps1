[CmdletBinding()]
Param(  [parameter(Mandatory=$true, HelpMessage="Process count")]
        [int]$Count = 10
 
        )

$Path = "C:\Scenario\file_3.txt"
Get-Process | Sort CPU -Descending | Select-Object -First $Count | Out-File "C:\Scenario\file_3.txt"
Get-Content $Path