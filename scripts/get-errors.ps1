#get all recent errors from major error logs
#because the windows event viewer is slow... really slow
$currentTime = get-date
$startTime = $currentTime.AddDays(-3)

$applicationLogName = "Application"
$systemLogName = "System"

$application = get-eventlog -log $applicationLogName    -newest 1000 | where-object {($_.EntryType -eq 'Error' -or $_.EntryType -eq 'Critical') -and $_.TimeGenerated -gt $startTime}
$system = get-eventlog -log $systemLogName              -newest 1000 | where-object {($_.EntryType -eq 'Error' -or $_.EntryType -eq 'Critical') -and $_.TimeGenerated -gt $startTime}

$recentErrors = new-object System.Collections.ArrayList
$recentErrors.AddRange($application)
$recentErrors.AddRange($system)

$basePath = "C:\dev\GitHub\PowerShell\scripts\"
$outputPath = $basePath + "recentErrors.html"
$cssPath = $basePath + "get-errors.css"

$recentErrors | convertto-html -CssUri $cssPath -title "Windows Error Logs" -property EntryType, TimeGenerated, Message, Source, UserName | set-content $outputPath
ii $outputPath
