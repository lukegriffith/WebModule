using namespace System.Collections.Generic
using namespace System.Net

# Loading functions
Get-ChildItem $PSScriptRoot -Recurse -Filter "*.ps1" | ForEach-Object -Process {
    .  $_.fullname
}


<#

    Have a class that can be obtained by using module psweb, this class can be used to register controllers. 

#>

<#
    Has a recorded number of controllers that will be used to respond with data.
#>
class ControllerRegister { 

    [List[Controller]]$Controlers


    [void]Register([Controller]$Controller) {

    }

    [psWebResponse]ProcessRequest([System.Net.HttpListenerRequest]$request){

        $url = $request.url
        
        $controller = $this.Controlers | Where-Object {$_.gettype().name -eq $url.Segments[1]}
        if (! $controller   ) {
            # return pswebrespons with error
            throw "Controller not found"
        }
        

        $method = $controller.gettype().GetMethods().Where{$_.Name -eq $request.HttpMethod}

        if ( ! $method ) { 
            # return pswebrespons with error
            throw "Method not found" 
        }

        # empty array is for parameters.
        return $method.Invoke($controller,@())


    }

    

}

<#
    Controller class, can be inherted by other classes as a psudo interface.
    These classes can be registered in the Controller register

    http://*:<port>/<Controller>

#>
class Controller {

    [HttpListenerContext]$Context

    [void]SetCurrentContext([HttpListenerContext]$Context){
        $this.Context = $Context
    }

    [String]Get() {
        return "{'Name':'PowerShell Webserver2 v0.1'}"
    }

}


class psWebResponse {

    [String]$Content 

}