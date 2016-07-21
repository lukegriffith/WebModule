

function New-WebServer {

    param(
        [int]$port = 8083
    )

    $PrivateData = $MyInvocation.MyCommand.Module.PrivateData

    if (-not $PrivateData.Server) { 


        $prefix = "http://*:{0}/" -f $port

        Write-Verbose ("Creating listener on port {0}" -f $port)

        $server = [WebServer]::new()
        $server.CreateListener($prefix)

        $PrivateData["Server"] = $server

        return $server

    }
    else {
        Write-Error -Exception ("WebServer already running on {0}" -f $PrivateData.Server.Worker.HttpListener.Prefix )
    }

}