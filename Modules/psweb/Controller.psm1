using namespace System.Collections.Generic
using namespace System.Net

<#
    Has a recorded number of controllers that will be used to respond with data.
#>
class ControllerRegister { 

    [List[Controller]]$Controllers


    ControllerRegister() {
        $this.Controllers = [List[Controller]]::new()
    }

    <#
    !!!! ERROR THROWING ON THIS METHOD.

    #>

    [Controller]Get([string]$TypeName){
        return $this.Controllers.Where{$_.GetType().Name -eq $TypeName}|Select-Object -First 1
    }

    static [void]RegisterController([Controller]$Controller){

        [ControllerRegister]::GetRegister().Controllers.Add(
            $Controller
        )
    }

    <#
        Static instance to allow static method to return single object.
    #>
    static hidden [ControllerRegister]$Register
    static [ControllerRegister]GetRegister(){

        return [ControllerRegister]::Register
    }

    static [void]InitializeRegister(){
        if (-not [ControllerRegister]::Register){
            [ControllerRegister]::Register = [ControllerRegister]::new()
        }
        else{
            throw "Register already initialized."
        }
    }

}

<#
    Controller class, can be inherted by other classes as a psudo interface.
    These classes can be registered in the Controller register

    http://*:<port>/<Controller>

#>
class Controller {

    [HttpListenerContext]$Context
    [String]$Data
    [void]SetCurrentContext([HttpListenerContext]$Context){
        $this.Context = $Context
    }

    [String]Get() {
        return "{'Name':'PowerShell Webserver2 v0.1','Data':'$($this.Data)'}"
    }

    [void]Post([String]$Data){
        $this.Data = $Data + $Data2
    }

}

