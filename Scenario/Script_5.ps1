[CmdletBinding()]
Param(  [parameter(Mandatory=$false, HelpMessage="Registry path")]
        [string]$Path = "HKLM:\SOFTWARE\Microsoft",
        [parameter(Mandatory=$false, HelpMessage="Directory Path")]
        [string]$Directory = "D:\Scenario\",
        [parameter(Mandatory=$false, HelpMessage="XML path")]
        [string]$XMLPath = "D:\Scenario\File5_1.xml",
        [parameter(Mandatory=$false, HelpMessage="CSV path")]
        [string]$CSVPath = "D:\Scenario\File5_1.csv",
        [parameter(Mandatory=$false, HelpMessage="CSV path")]
        [string]$FilePath = "D:\Scenario"
     )

New-Item -ItemType Directory -Path $Directory
Get-ChildItem $Path | Export-Clixml -Path $XMLPath -Force
Import-Clixml -Path $XMLPath | ForEach-Object {Write-Host $_ -f DarkGray}
Get-HotFix | Export-Csv -Path $CSVPath
Import-Csv -Path $CSVPath | ForEach-Object {Write-Host $_ -b DarkGray}
