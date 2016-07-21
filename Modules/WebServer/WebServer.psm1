using Namespace System.Net;
using Namespace System.Management.Automation;
using Namespace System.Management.Automation.Runspaces;
using Namespace System.Collections.Generic;
using Namespace System.Collections;
using Namespace System.Runtime;

# Loading functions
Get-ChildItem $PSScriptRoot -Recurse -Filter "*.ps1" | ForEach-Object -Process {
    .  $_.fullname
}

<#
    WebServer class contains the session state for the workers and the worker class. 
    WebServer module is imported natively into the runsapces created, and Wait-Context is carried out on the HTTP context when the server is started.

#>
Class WebServer {


    [Worker] $Worker
    [initialsessionstate] $SessionState

    WebServer(){

        $this.SessionState = [initialsessionstate]::CreateDefault()
        $this.SessionState.ImportPSModule(@("WebServer"))

    }

    <#
        Method constructs listener and hands to classes worker property. 
        $this.CreateListener("http://*:8083")
    #>
    [void]CreateListener([string]$Prefix) {

        $http = [HttpListener]::new()
        $http.Prefixes.Add($Prefix)

        $listener = [Listener]::New($http, $Prefix)

        $runspace = [runspacefactory]::CreateRunspace($this.SessionState)
        $runspace.Open()
        $runspace.SessionStateProxy.SetVariable("Listener",$listener)
        
        
        $powershell = [Powershell]::Create()
        $powershell.runspace = $runspace

        $powershell.AddScript("Wait-Context -Listener `$Listener")

        $this.worker = [Worker]::new($listener,$powershell)


    }
}


<#

    Worker class is a class that maps the runner and the listner that is running in its space.
    Executing stop on the class will stop the HttpListener and in turn cause any powershell runspace to complete, this allows to cleanly tear down the listner without causing any locked ports.

#>
class Worker {

    [Listener]$HttpListener
    [PowerShell]$Runner


    hidden [ArrayList]$iAsyncList

    [string[]]$Prefix

    Worker([Listener]$http, [PowerShell]$powershell){

        $this.HttpListener = $http
        $this.Runner = $powershell
        $this.iAsyncList = [ArrayList]::new()
    }

    [void] Start() {
        $this.HttpListener.Start()
        $this.Prefix = $this.HttpListener.Prefix

        $iasync = $this.Runner.BeginInvoke()
        $this.iAsyncList.Add( $iasync )
    }

    [void] Stop() {
        $this.HttpListener.Stop()
    }


}

<#
    Listener class contains the HttpListener and a Boolean to let the worker know if it should be responding to requests. $_
    Start and Stop is implemented into the Worker, Dispose is still a method on this that needs to be taken further up.

    I question if I actually need the Stop and Start methods on this, and do it entierly on the worker. I need to think about this further. 

#>
class Listener {

    [String]$Prefix
    [HttpListener]$Http
    [Bool]$IsListening


    [void] Start() { 
        $this.Http.Start()
        $this.IsListening = $true 
    }

    [void] Stop() { 
        $this.IsListening = $false
        $this.Http.stop()
    }

    [void] DisposeListener() {
        $this.Http.Dispose()
    }

    Listener([HttpListener]$Http, [String]$Prefix) {

        $this.Http = $Http
        $this.Prefix = $Prefix
    }


}



