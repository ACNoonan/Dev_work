 [System.Collections.ArrayList]$FileNames = @()
 $TesterFolder = "\\192.168.37.109\bc01"
 Get-ChildItem -Recurse $TesterFolder | % {
    if(! $_.PSIsContainer){
    $FileNames += $_.FullName
    }
}
$FileNames