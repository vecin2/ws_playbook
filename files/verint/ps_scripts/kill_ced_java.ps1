$ProcessToKill=(Get-WmiObject Win32_Process  -Filter "name like '%Java%' and commandLine like '%Toolbox.jar%'")

if ($ProcessToKill -eq $Null) { 
  Write-Host "ad container not running" 
}
else {
  Write-Host "killing ad container" 
  $ProcessToKill.Terminate()
}
