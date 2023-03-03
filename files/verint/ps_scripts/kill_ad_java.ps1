#$ProcessToKill=(Get-WmiObject Win32_Process  -Filter "name like '%Java%' and commandLine like '%Dweblogic.name=Admin%'")
$ProcessToKill=Get-Process | Where-Object {$_.WorkingSet -gt 500*1000000 -and $_.Name -eq 'javaw'}
if ($ProcessToKill -eq $Null) { 
  Write-Host "ad container not running" 
}
else {
  Write-Host "killing ad container" 
  $ProcessToKill.Kill()
}
