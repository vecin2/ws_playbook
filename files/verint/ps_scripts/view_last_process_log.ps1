$EMProjectHome=Get-Content -Path Env:\EM_PROJECT_HOME
$ProcessLogsPath=$EMProjectHome + "logs\ad\cre\session\process\"
$Files=gci  $ProcessLogsPath | sort LastWriteTime | select -last 2

if ($Files[1] -like '*HotUpdate*'){
  $LogToView=$Files[1].FullName
}
else{
  $LogToView=$Files[0].FullName
}
Write-Host "Opening log at "$LogToView
start $LogToView
