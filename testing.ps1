using Module WebServer

$server = [WebServer]::new()
$server.CreateListener("http://*:8083/")
$server.Listeners[0].Start()