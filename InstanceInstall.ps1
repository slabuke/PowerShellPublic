
########################################_________RDP(Rules and connection)_______________###########################
Set-ItemProperty ‘HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\‘ -Name “fDenyTSConnections” -Value 0                          #enable RDP
Set-ItemProperty ‘HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\‘ -Name “UserAuthentication” -Value 1      #Security authorization to RDP enable

          If (New-Object System.Net.Sockets.TCPClient -ArgumentList 'VM1',3389) { Write-Host 'RDP connection is open'-BackgroundColor Green }   #Connection test
          If ($? -eq $false) { Write-Host 'RDP connection closed' -BackgroundColor Red }

########################################_________RDP(Rules and connection)_______________###########################
New-NetFirewallRule -DisplayName “SQL Server” -Direction Inbound –Protocol TCP –LocalPort 1433 -Action allow                            #NewFirewallRules
New-NetFirewallRule -DisplayName “SQL ServerUDP” -Direction Inbound –Protocol UDP –LocalPort 1434 -Action allow                         #NewFirewallRules
         If (Get-NetFirewallRule | Where { $_.Enabled –eq ‘True’ –and $_.DisplayName –eq ‘SQL Server’ }) {Write-Host 'SQLTCP Rule ACtive'-BackgroundColor Green}
         else {Write-Host 'SQLTCP Rule Inactive' -BackgroundColor Red}
         If (Get-NetFirewallRule | Where { $_.Enabled –eq ‘True’ –and $_.DisplayName –eq ‘SQL ServerUDP’ }) {Write-Host 'SQLUDP Rule ACtive' -BackgroundColor Green}
         else {Write-Host 'SQLUDP Rule Inactive' -BackgroundColor Red}
########################################_________SQL NEW INSTANCE)_______________###########################
$Server = @("VM1")
Invoke-Command -ScriptBlock {
D:\setup.exe /SAPWD="QWErty123" /CONFIGURATIONFILE="C:\ConfigurationFile.ini" | Out-Null


########################################_________SQL Instance List_______________###########################
d:\setup.exe /action=RunDiscovery /quiet
$latest = Get-ChildItem -Path "C:\Program Files\Microsoft SQL Server" -Filter summary.txt -Recurse -Force |`
Sort-Object LastAccessTime -Descending | Select-Object -First 1
Get-content $latest.FullName

