[int]$S = 0
Get-Variable | ForEach-Object{if($_.Value -is [int]) {$S += $_.Value} }
$S