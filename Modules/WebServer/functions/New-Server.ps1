

function New-Server {
    param(
        [int]$port = 8083
    )

    $prefix = "http://*:{0}/" -f $port

    $server = [WebServer]::new()
    $server.CreateListener($prefix)


}