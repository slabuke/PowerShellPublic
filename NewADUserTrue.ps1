$ADUsers = Import-Csv -Delimiter ';' -Path "C:\Users\ASUS\Desktop\users1.csv"
Invoke-Command -ScriptBlock {
Param($ADUsers)
Import-Module ActiveDirectory
$OU = "OU=Lab_Users,DC=NV,DC=lab"
foreach ($Users in $ADUsers) 
{
 $FirstName = $Users.FirstName
 $LastName = $Users.LastName
 $Username = $Users.FirstName + $users.LastName
 $Password = $Users.DefaultPassword
 $Department = $Users.Department

 if (Get-ADUser -Filter {SamAccountName -eq $Username})
 {
 Write-Warning "A user account with username $Username already exist in Active Directory."
 }
 else
 {
  New-ADUser `
  -SamAccountName $Username `
  -UserPrincipalName "$Username@nv.lab" `
  -Name "$Firstname $Lastname" `
  -GivenName $Firstname `
  -Surname $Lastname `
  -Enabled $True `
  -DisplayName "$Lastname, $Firstname" `
  -Department $Department `
  -Path $OU `
  -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $True
  

}
}
} -ComputerName DC01 -Credential Administrator -ArgumentList $ADUsers