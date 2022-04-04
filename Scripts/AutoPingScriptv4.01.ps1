<#
.NOTES
    Version: 4.1 
    Author: Adam Noonan
    Last Edit: 9/5/2019
.SYNOPSIS
   Ping IP Address List
.DESCRIPTION
   Takes a list of IP Addresses in .csv file format and sends an ICMP echo to echo, adding output (IP Address, Status & DateTime)
   to a text file
.EXAMPLE
   Automated via Task Scheduler
.INPUT
   $inputFile = .csv file of IP Addresses to ping
.OUTPUT
   $outFile = .txt document of IP Address, Status & DateTime of script operation

------------------------------------------------------------[Change Log]----------------------------------------------------------
    4.1
    -Fit script to template
#>
#---------------------------------------------------------[Initialisations]--------------------------------------------------------
#Set Error Action to All Errors Terminate
#$ErrorActionPreference = "Stop"
#----------------------------------------------------------[Declarations]----------------------------------------------------------
#Clear Screen
cls
#-----------------------------------------------------------[Functions]------------------------------------------------------------
function AutoPing-IPs
{
    [CmdletBinding(ConfirmImpact="Low",
    HelpURI="https://gallery.technet.microsoft.com/scriptcenter/Powershell-Script-to-ping-15e0610a")]
    [Alias()]
    [OutputType([int])]
    Param
    ()

    Begin{
          #Input/Output Files
          $inputFile = "C:\Users\adamnoonan\Documents\Documents\AutoPing\IPAddressList.csv"
          $outFile = "C:\Users\adamnoonan\Documents\Documents\AutoPing\PingResults.txt"
    }

    Process{
        Try{
            #Get Input, process Input
            $info = Get-Content $inputFile | foreach{
                If(Test-Connection -ComputerName $_ -Count 1 -Quiet) {
                $status = Write-Output "Active"
                }
                Else{
                $status = Write-Output "Inactive"
            }

            #Create Output Object
            [pscustomobject][ordered]@{
                PCName  = $_
                Status  = $status
                DateTime = Get-Date            
                                      }
            }
        #Generate/Append Output
        $info | Add-Content $outFile
        }

        Catch{
            Write-Host "An error has occurred that could not be resolved:"
            Write-Host $_
        }
    }

    End{
        IF($?){
        }
    }
}
#-----------------------------------------------------------[Execution]------------------------------------------------------------
AutoPing-IPs

  
    
     
    
            