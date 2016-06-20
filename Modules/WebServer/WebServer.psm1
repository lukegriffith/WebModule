using Namespace System.Net;
using Namespace System.Management.Automation;
using Namespace System.Management.Automation.Runspaces;
using Namespace System.Collections.Generic;

Get-ChildItem $PSScriptRoot -Recurse -Filter "*.ps1" | ForEach-Object -Process {
    .  $_.fullname
}

class Server {

    [List[Worker]]$Workers
    [Worker]Create(){
        return [Worker]::new("blah")
    }
}

class Responder {

        [RunspacePool] $runPool;
        [int] $Threads = 25;

        Responder() {

            $this.runPool = [RunspaceFactory]::CreateRunspacePool();
            $this.runPool.SetMaxRunspaces($this.Threads);
            $this.runPool.Open()
        }
}

class Worker {

    [Responder]$Responder
    [HttpListener]$Listener
    [PSObject]$Result

    Worker([string]$prefix){

        $this.Listener = CreateListener $prefix
        $this.Responder = [Responder]::new()
    }
}