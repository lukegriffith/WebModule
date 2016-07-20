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


    [List[Listener]] $Listeners

    [initialsessionstate] $SessionState


    Server(){

        $this.Listeners = [Hashtable]::Synchronized(@{})

        $this.SessionState.ImportPSModule("WebServer")


    }


    # Creates Listener object, and adds to shared hashtable

    [void]CreateListener([string]$Prefix, [String]$Key) {

        $http = [HttpListener]::new()
        $http.Prefixes.Add($Prefix)



        $runspace = [runspacefactory]::CreateRunspace($this.initialsessionstate)
        $runspace.initialsessionstate
        $runspace.SessionStateProxy.SetVariable("Listener",$http)
        $runspace.Open()
        
        $powershell = [Powershell]::Create()
        $powershell.runspace = $runspace

        $powershell.AddScript("Wait-Context -Listener `$Listener")

        $listener = [Listener]::New($http, $powershell, $Prefix)


        $this.Listeners.Add($Key, $listener)         


    }
}


class Listener {

    [String]$Prefix
    [HttpListener]$Http
    [PowerShell]$shell
    [Bool]$IsListening


    [void] Start() { 
        $this.Http.Start()
        $this.IsListening = $true 
        $this.shell.Invoke()
    }

    [void] Stop() { 
        $this.IsListening = $false
        $this.Http.stop()
    }

    [void] DisposeListener() {
        $this.Http.Dispose()
    }

    Listener([HttpListener]$Http, [Powershell]$Shell, [String]$Prefix) {

        $this.Http = $Http
        $this.shell = $Shell
        $this.Prefix = $Prefix
    }


}



