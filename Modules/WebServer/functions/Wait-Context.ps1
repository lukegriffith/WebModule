using Namespace System.Net;
using Module WebServer;


function Wait-Context {
    Param(
        [Listener]$Listener
    )

    While ($Listener.IsListening) {

        $response = $Listener.Http.GetContext()
        Initialize-Response -Response $response

    }
    


}