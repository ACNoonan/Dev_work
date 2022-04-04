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