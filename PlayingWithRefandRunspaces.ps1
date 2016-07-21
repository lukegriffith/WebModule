using Namespace System.Net;


class Listen {


    [HttpListener]$Http
    [Bool]$IsListening = $true
}



$prefix = "http://*:8083/"

$http = [HttpListener]::new()
$http.Prefixes.Add($prefix)
$http.Start()


$a = [Listen]::new()

$a.Http = $http

    
$rs = [runspacefactory]::CreateRunspace()
$rs.Open()
$rs.SessionStateProxy.SetVariable("Listener",$a)



$ps = [PowerShell]::Create()

$ps.Runspace = $rs

$ps.AddScript("`$Listener.Http.GetContext(); return `$Listener.IsListening")


$iasync = $ps.BeginInvoke()

#$http.GetContext()


