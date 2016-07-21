using Namespace System.Net;
using Namespace System.Management.Automation;
using Namespace System.Management.Automation.Runspaces;
using Namespace System.Collections.Generic;
using Namespace System.Collections;
using Namespace System.Runtime;


Get-ChildItem $PSScriptRoot -Recurse -Filter "*.ps1" | ForEach-Object -Process {
    .  $_.fullname
}


Class WebServer {


    [Worker] $Worker

    [initialsessionstate] $SessionState


    WebServer(){

        

        $this.SessionState = [initialsessionstate]::CreateDefault()

        $this.SessionState.ImportPSModule(@("WebServer"))


    }


    # Creates Listener object, and adds to shared hashtable

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



