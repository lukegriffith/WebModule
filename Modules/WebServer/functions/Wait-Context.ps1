using Namespace System.Net;



function Wait-Context {
    Param(
        [Listener]$Listener
    )

    While ($Listener.IsListening) {

        $context = $Listener.Http.GetContext()
        Initialize-Response -Context $context
        Start-Sleep -Milliseconds 100

    }
    


}