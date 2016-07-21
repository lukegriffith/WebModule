using Module WebServer

$server = [WebServer]::new()
$server.CreateListener("http://*:8083/")
$server.Worker.Start()