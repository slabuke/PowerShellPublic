[CmdletBinding()]
Param(  [parameter(Mandatory=$true, HelpMessage="Running|Stopped")]
        [string]$Status = "Running",
        [string]$Path = "C:\Scenario\file1.txt",
        [parameter(Mandatory=$true, HelpMessage="Select disk C:\")]
        [string]$Disk
    )
[string]$services = ""
Get-Service | %{
    if($_.status -eq $Status){$services += $_.Name + ", "}
}
$services | Out-File -FilePath $Path
Get-ChildItem -Path $Disk
Get-Content $Path
