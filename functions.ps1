# Function used to start worker using the [worker] constructor

function start-worker {
        
        param(
            $context
        )
    
    
    Write-Verbose "context recieved, constructing worker"
    $worker = [worker]::new($context)
    # Throw in logging capabilities here
    Write-Verbose "worker constructed, processing request"
    $worker.ProcessRequest()
    Write-Verbose "request processed"
}

# Function initiates the webserver, and invokes the runspaces to multithread the application.

function Start-psWebServer  {


    $http = [System.Net.HttpListener]::new()
    $http.Prefixes.Add("http://*:8081/")
    $http.Start()
    Write-Output "Started WebServer"

    $whileCount = 0 
    while ($true) {
    $context = $http.GetContext()
    
    
    
    Write-Output "Invoking RunSpace"

    $runspace = [runspacefactory]::CreateRunspace()       
    $runspace.Open()                                      
    $runspace.SessionStateProxy.SetVariable('context',$context)   
    $runspace.SessionStateProxy.SetVariable('scriptRoot',$PSScriptRoot)  
    $powershell = [powershell]::Create()                  
    $powershell.Runspace = $runspace     
    
    # Need to move scripts over to a module                 
    $powershell.AddScript( {. "$scriptRoot\classes.ps1"; . "$scriptRoot\functions.ps1" ;  start-worker $context} ) | Out-Null    
    $handle = $powershell.BeginInvoke()                                                           
    $powershell.EndInvoke($handle)                   
    $runspace.Close()
    $powershell.Dispose()     
     

    

    }

    
}