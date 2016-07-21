using Namespace System.Net;



function Wait-Context {
    Param(
        [Listener]$Listener
    )

    While ($Listener.IsListening) {

        $context = $Listener.Http.GetContext()
        $global:i++
        Initialize-Response -Context $context
        Start-Sleep -Milliseconds 100

    }
    


}