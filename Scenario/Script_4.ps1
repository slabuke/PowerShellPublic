[CmdletBinding()]
Param(  [parameter(Mandatory=$true, HelpMessage="Path of summing")]
        [string]$Path,
        [parameter(Mandatory=$true, HelpMessage="FormatType .type")]
        [string]$Format
)
[int]$Sum = 0
Get-ChildItem -Recurse -Path $Path | %{if($_.Name -ne $Format){$Sum += $_.Length}} 
$Sum
