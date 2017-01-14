using namespace System.Collections.Generic
using namespace System.Net

# Loading functions
Get-ChildItem $PSScriptRoot -Recurse -Filter "*.ps1" | ForEach-Object -Process {
    .  $_.fullname
}


<#
    Has a recorded number of controllers that will be used to respond with data.
#>
class ControllerRegister { 

    [List[Controller]]$Controllers


    [void]Register([Controller]$Controller) {
        $this.Controllers = [List[Controller]]::new()
    }

    [Controller]Get([string]$TypeName){
        return $this.Controllers.Where{$_.GetType().Name -eq $TypeName}
    }

    <#
        Static instance to allow static method to return single object.
    #>
    static hidden [ControllerRegister]$Register
    static [ControllerRegister]GetRegister(){

        if (-not [ControllerRegister]::Register){
            [ControllerRegister]::Register = [ControllerRegister]::new()
        }

        return [ControllerRegister]::Register
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
        $this.Data = $Data
    }

}

