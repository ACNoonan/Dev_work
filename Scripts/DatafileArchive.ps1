<#
.NOTES
    Version: 1.0
    Author: Adam Noonan
    Last Edit: 12/17/2019
.SYNOPSIS
   Script is designed with the purspose of archiving data files by their last modified date.
.DESCRIPTION
   The script cycles through files in the InputPath subdirectory, creating a folder structure for each day (year\month\day) at the given output path. 
   Then the script will **MOVE** each file into it's respective subdirectory. 
.INPUT
   $InPath = Subdirectory with data files that need archiving.
   $OutPath = Desired subdirectory for archived files. 
.OUTPUT
   $YearPath = Subdirectory with year of last modification for data files in $InPath. 
   $MonthPath = Subdirectory with month of last modification for data files in $InPath. 
   $DayPath = Subdirectory with day of last modification for data files in $InPath. 

                                                **NOTE**
    -This version of the PowerShell template requires reference to another script ('WriteLog.ps1'),
                also found in '\\s-fs2\it\ApplicationsGroup\Development\PowerShell'. 
    If this script moves location, the logging funcitons will not work and this script may fail.
                                              **END NOTE**

------------------------------------------------------------[Change Log]----------------------------------------------------------
    1.0
    -Initial deployment.
#>
#---------------------------------------------------------[Initializations]--------------------------------------------------------
#Set Error Action to All Errors Terminate
#$ErrorActionPreference = "Stop"

#Reference to Script with required Function Libraries
. "\\s-fs2\it\ApplicationsGroup\Development\PowerShell\WriteLog.ps1"
#----------------------------------------------------------[Declarations]----------------------------------------------------------
#Script Version
#$sScriptVersion = "1.0"

#Log File Info
$sLogPath = "C:\Windows\Temp"
$sLogName = "DatafileArchive.log"
$sLogFile = Join-Path -Path "$sLogPath" -ChildPath "$sLogName"


#-----------------------------------------------------------[Functions]------------------------------------------------------------
function Archive-DataFiles
{
    [CmdletBinding(ConfirmImpact="Low",
    HelpURI="https://stackoverflow.com/questions/39938194/powershell-move-files-to-folder-based-on-date-created")]
    [Alias()]
    [OutputType([int])]
    Param
    ()

    Begin{
    Log-Write -LogPath "$sLogFile" -LineValue "Starting DatafileArchive Script..."
    }


    Process{
        Try{

        $Inputpath = ""
        $file = ""
        $date  = ""
        $month   = ""
        $year    = ""
        $MonthPath   = ""
        
        
        $InputPath = Read-Host "Please provide the directory with files for arhciving."
        
        $OutPath = Read-Host "Please provide the directory to output the archived files."
        
        Write-Warning "Note: This action can take several minutes, depending on the amount of files in $FilePath."
        
        
        get-childitem $InputPath | % {
        
          $file = $_.FullName 
          $date = Get-Date ($_.LastWriteTime)
        
          $month = $date.month
          $year = $date.year
          $day = $date.day
            $YearPath = "$OutPath\$year"
            $MonthPath = "$OutPath\$year\$month"
            $DayPath = "$OutPath\$year\$month\$day"
            Write-Verbose "month = $month"
            Write-Verbose "Date = $date"
            Write-Verbose "year = $year"
            Write-Verbose "OutPath = $OutPath" 
            Write-Verbose "Filename = $file"
            Write-Verbose "YearPath = $YearPath"
            Write-Verbose "MonthPath = $MonthPath"
            Write-Verbose "DayPath = $DayPath"
        
        
            if(!(Test-Path -Path "$YearPath" )){
                Write-Verbose "Creating log location $YearPath."
                Write-Verbose "YearPath inside path test = $YearPath"
                New-Item -ItemType directory -Path $YearPath | Out-null
            }
        
            if(!(Test-Path -Path "$MonthPath" )){
                    Write-Verbose "Creating log location $MonthPath."
                    Write-Verbose "MonthPath inside path test = $MonthPath"
                    New-Item -ItemType directory -Path $MonthPath | Out-null
            }
        
            if(!(Test-Path -Path "$DayPath" )){
                        Write-Verbose "Creating log location $DayPath."
                        Write-Verbose "DayPath inside path test = $DayPath"
                        New-Item -ItemType directory -Path $DayPath | Out-null
            }
        
            ELSE {
                #Write-Host -backgroundcolor green -ForegroundColor black "Log location exists already exist $MonthPath"
                Write-Verbose "Log location exists already exist $DayPath" 
                }
            move-item "$file" "$DayPath" | Out-null
        }
        
        Write-Warning "All files are sorted now based upon date of last modification."
            
        }
        Catch{
        }
    }


    End{
        IF($?){
            Log-Write -LogPath "$sLogFile" -LineValue "Completed Successfully."
            Log-Write -LogPath "$sLogFile" -LineValue " "
        }
    }
}


#-----------------------------------------------------------[Execution]------------------------------------------------------------
#Log-Start -LogPath $sLogPath -LogName $sLogName 
Archive-DataFiles
#Log-Finish -LogPath $sLogFile

  
    
     
    
            