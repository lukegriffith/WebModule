
<#
    .Description
    Queries module private data to see if a WebServer has been initialised in the module. 

    .Notes
        ChangeLog
        21/07/2016 - Created by Luke Griffith

#>
function Get-WebServer {
    [cmdletbinding()]
    param()

    $ErrorActionPreference = "Stop"

    $Server =  $MyInvocation.MyCommand.Module.PrivateData["Server"]

    if ($null -eq $server) {
        Write-Error -Exception "Unable to find server."
    }

    return $Server

}