<#


#>
$info = Get-Content C:\Users\adamnoonan\Documents\Documents\AutoPing\IPAddressList.csv | foreach{
    If(Test-Connection -ComputerName $_ -Count 1 -Quiet) {
        $status = Write-Output "Active"
    }Else {
        $status = Write-Output "Inactive"
       }

    [pscustomobject][ordered]@{
            PCName  = $_
            Status  = $status
            DateTime = Get-Date            
            }
}
$info | Add-Content C:\Users\adamnoonan\Documents\Documents\AutoPing\PingResults.txt
  
    
     
    
            