<#
    .Description 
    Given a WebServer object, it will start listening and responding to requests on the given port.
    
    .Notes
        ChangeLog:
            21/07/2016 - Created By Luke Griffith

    .Example 
    PS> New-WebServer | Start-WebServer

    .Example 
    PS> New-WebServer
    
    Worker
    ------
    Worker

    PS> Get-WebServer | Start-WebServer


#>
function Start-WebServer {
    [cmdletbinding()]
    param(
        <#
            Provide a WebServer object, created by New-WebServer, or obtained by Get-WebServer.
        #>
        [Parameter(ValueFromPipeline=$true)]
        [WebServer]$Server
    )

    Process {
        $_.Worker.Start()
    }
}