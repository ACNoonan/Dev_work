$RootFolder = ""
$OutFolder = ""

#$RootFolder = ""
#$OutFolder = ""

$RootFolderAppend = $RootFolder.Split('\')[-1]
$OutPath = "$OutFolder\$RootFolderAppend"
if(!(Test-Path -Path "$OutPath")){
    New-Item -ItemType directory -Path "$OutPath" | Out-null
}

Get-ChildItem -Recurse $RootFolder -Depth 0 | % {
    if($_.PSIsContainer){
        #Write-Host "Level 1 SubFolders are as follows: " $_.FullName
        $SubFolder1Append = $_.FullName.Split('\')[-1]
        $NewOutPath1 = "$OutPath\$SubFolder1Append"
        if(!(Test-Path -Path "$NewOutPath1")){
            New-Item -ItemType directory -Path "$NewOutPath1" | Out-null
        }

        Get-ChildItem -Recurse $_.FullName -Depth 0 | % {
            if($_.PSIsContainer){
                #Write-Host "Level 2 SubFolders are as follows: " $_.FullName
                $SubFolder2Append = $_.FullName.Split('\')[-1]
                $NewOutPath2 = "$OutPath\$SubFolder1Append\$SubFolder2Append"
                if(!(Test-Path -Path "$NewOutPath2")){
                    New-Item -ItemType directory -Path "$NewOutPath2" | Out-null
                }
        
                Get-ChildItem -Recurse $_.FullName -Depth 0 | % {
                    if($_.PSIsContainer){
                        #Write-Host "Level 3 SubFolders are as follows: " $_.FullName
                        $SubFolder3Append = $_.FullName.Split('\')[-1]
                        $NewOutPath3 = "$OutPath\$SubFolder1Append\$SubFolder2Append\$SubFolder3Append"
                        if(!(Test-Path -Path "$NewOutPath3")){
                            New-Item -ItemType directory -Path "$NewOutPath3" | Out-null
                        }

                        Get-ChildItem -Recurse $_.FullName -Depth 0 | % {
                            if(! $_.PSIsContainer){
                                #Write-Host "I found some files: " $_.FullName

                                $Inputpath = $_.FullName
                                $file = ""
                                $date  = ""
                                $month   = ""
                                $year    = ""
                                $MonthPath   = ""
                                
                                get-childitem $InputPath | % {
                                
                                    $file = $_.FullName 
                                    $date = Get-Date ($_.LastWriteTime)
                                    
                                    $month = $date.month
                                    $year = $date.year
                                    $day = $date.day
                                
                                
                                    $YearPath = "$NewOutPath3\$year"
                                    $MonthPath = "$NewOutPath3\$year\$year-$month"
                                    $DayPath = "$NewOutPath3\$year\$year-$month\$year-$month-$day"
                                    
                                                        
                                    if(!(Test-Path -Path "$YearPath" )){
                                        New-Item -ItemType directory -Path $YearPath | Out-null
                                    }
                                
                                    if(!(Test-Path -Path "$MonthPath" )){
                                        New-Item -ItemType directory -Path $MonthPath | Out-null
                                    }
                                
                                    if(!(Test-Path -Path "$DayPath" )){
                                        New-Item -ItemType directory -Path $DayPath | Out-null
                                    }
                                
                                    ELSE {
                                        Write-Verbose "Log location already exist $DayPath" 
                                    }
                                
                                    #move-item "$file" "$DayPath" | Out-null
                                    copy-item "$file" "$DayPath" | Out-null
                                }
                            } 
                        }
                    }
                    if(! $_.PSIsContainer){
                        #Write-Host "I found some files: " $_.FullName

                        $Inputpath = $_.FullName
                        $file = ""
                        $date  = ""
                        $month   = ""
                        $year    = ""
                        $MonthPath   = ""
                        
                        get-childitem $InputPath | % {
                        
                            $file = $_.FullName 
                            $date = Get-Date ($_.LastWriteTime)
                            
                            $month = $date.month
                            $year = $date.year
                            $day = $date.day
                        
                        
                            $YearPath = "$NewOutPath2\$year"
                            $MonthPath = "$NewOutPath2\$year\$year-$month"
                            $DayPath = "$NewOutPath2\$year\$year-$month\$year-$month-$day"
                            
                                                
                            if(!(Test-Path -Path "$YearPath" )){
                                New-Item -ItemType directory -Path $YearPath | Out-null
                            }
                        
                            if(!(Test-Path -Path "$MonthPath" )){
                                New-Item -ItemType directory -Path $MonthPath | Out-null
                            }
                        
                            if(!(Test-Path -Path "$DayPath" )){
                                New-Item -ItemType directory -Path $DayPath | Out-null
                            }
                        
                            ELSE {
                                Write-Verbose "Log location already exist $DayPath" 
                            }
                        
                            #move-item "$file" "$DayPath" | Out-null
                            copy-item "$file" "$DayPath" | Out-null
                        }
                    }
                }
            }
            if(! $_.PSIsContainer){
                #Write-Host "I found some files: " $_.FullName

                $Inputpath = $_.FullName
                $file = ""
                $date  = ""
                $month   = ""
                $year    = ""
                $MonthPath   = ""
                
                get-childitem $InputPath | % {
                
                    $file = $_.FullName 
                    $date = Get-Date ($_.LastWriteTime)
                    
                    $month = $date.month
                    $year = $date.year
                    $day = $date.day
                
                
                    $YearPath = "$NewOutPath1\$year"
                    $MonthPath = "$NewOutPath1\$year\$year-$month"
                    $DayPath = "$NewOutPath1\$year\$year-$month\$year-$month-$day"
                    
                                        
                    if(!(Test-Path -Path "$YearPath" )){
                        New-Item -ItemType directory -Path $YearPath | Out-null
                    }
                
                    if(!(Test-Path -Path "$MonthPath" )){
                        New-Item -ItemType directory -Path $MonthPath | Out-null
                    }
                
                    if(!(Test-Path -Path "$DayPath" )){
                        New-Item -ItemType directory -Path $DayPath | Out-null
                    }
                
                    ELSE {
                        Write-Verbose "Log location already exist $DayPath" 
                    }
                
                    #move-item "$file" "$DayPath" | Out-null
                    copy-item "$file" "$DayPath" | Out-null
                }
            }

        }
    }
    if(! $_.PSIsContainer){
        #Write-Host "I found some files: " $_.FullName

        $Inputpath = $_.FullName
        $file = ""
        $date  = ""
        $month   = ""
        $year    = ""
        $MonthPath   = ""
        
        get-childitem $InputPath | % {
        
            $file = $_.FullName 
            $date = Get-Date ($_.LastWriteTime)
            
            $month = $date.month
            $year = $date.year
            $day = $date.day
        
        
            $YearPath = "$OutPath\$year"
            $MonthPath = "$OutPath\$year\$year-$month"
            $DayPath = "$OutPath\$year\$year-$month\$year-$month-$day"
            
                                
            if(!(Test-Path -Path "$YearPath" )){
                New-Item -ItemType directory -Path $YearPath | Out-null
            }
        
            if(!(Test-Path -Path "$MonthPath" )){
                New-Item -ItemType directory -Path $MonthPath | Out-null
            }
        
            if(!(Test-Path -Path "$DayPath" )){
                New-Item -ItemType directory -Path $DayPath | Out-null
            }
        
            ELSE {
                Write-Verbose "Log location already exist $DayPath" 
            }
        
            #move-item "$file" "$DayPath" | Out-null
            copy-item "$file" "$DayPath" | Out-null
        }
    }
}
