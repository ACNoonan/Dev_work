<#
.SYNOPSIS
    Ping a list of IP Addresses (.csv format) and append output/results to a text-file. 

.INPUTS
    IPAddressList.csv: List of IP Addresses.

.OUTPUTS
    PingResults.txt: List of ping results (IP Address, Status & DateTime).

#>

#Requires -Version 1.0

#Get IP Addresses, loop through and Test-Connection 
$info = Get-Content C:\Users\adamnoonan\Documents\Documents\AutoPing\G300Machines.csv | foreach{
    If(Test-Connection -ComputerName $_ -Count 1 -Quiet) {
        $status = Write-Output "Active"
    }Else {
        $status = Write-Output "Inactive"
       }

#Create ordered object array for output 
    [pscustomobject][ordered]@{
            PCName  = $_
            Status  = $status
            DateTime = Get-Date            
            }
}
$info | Add-Content C:\Users\adamnoonan\Documents\Documents\AutoPing\G300PingResults.txt
  
    
     
    
            