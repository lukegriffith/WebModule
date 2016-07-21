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