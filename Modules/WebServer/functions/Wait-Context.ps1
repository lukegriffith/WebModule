using Namespace System.Net;

<#
    .Description
    Internal function used by the WebServer to wait for context by the HttpListener. This passes the context onto Initialize-Response what handles returning the content back to the requester. 

    .Notes
        Change Log:
        20/07/2016 - Created by Luke Griffith

#>
function Wait-Context {
    Param(
        [Listener]$Listener
    )

    While ($Listener.IsListening) {

        $context = $Listener.Http.GetContext()
        Read-Context -Context $context
        Start-Sleep -Milliseconds 100

    }
    


}