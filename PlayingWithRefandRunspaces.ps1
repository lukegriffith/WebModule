using Namespace System.Net;


$prefix = "http://*:8083/"

$http = [HttpListener]::new()
$http.Prefixes.Add($prefix)
$http.Start()
    
$rs = [runspacefactory]::CreateRunspace()
$rs.Open()
$rs.SessionStateProxy.SetVariable("Listener",[ref]$http)



$ps = [PowerShell]::Create()

$ps.Runspace = $rs

$ps.AddScript("`$Listener.value.GetContext()")


$iasync = $ps.BeginInvoke()

#$http.GetContext()