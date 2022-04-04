try{
$cred = Get-Credential 
Enter-PSSession  -ComputerName S-ADCON -Credential $cred 
#cd '\\S-ADCON\c$\Program Files\Microsoft Azure AD Sync\Bin\adsync' 
Get-module ADSync | Import-Module ADSync
#Import-Module .\ADSync.psd1
Start-ADSyncSyncCycle -PolicyType Delta  
Exit-PSSession
}
catch{
echo $_.Exception|format-list -force
$Date = Get-Date -format "dddd MM/dd/yyyy HH:mm "
echo $Date
}