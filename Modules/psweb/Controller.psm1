using namespace System.Management.Automation
using namespace System.Collections.Generic
using namespace System.Net
using module ..\attributes\Web.psm1

<#
    Has a recorded number of controllers that will be used to respond with data.
#>
class ControllerRegister { 

    [List[CommandInfo]]$Controllers


    ControllerRegister() {
        $this.Controllers = [List[CommandInfo]]::new()
    }

    <#
    !!!! ERROR THROWING ON THIS METHOD.

    #>

    [CommandInfo]Get([string]$FunctName){
        return $this.Controllers.Where{$_.Name -eq $FunctName}[0]
    }

    static [void]RegisterController([CommandInfo]$Controller){

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


class Controller {

    [String]$Route


}


class ClassController : Controller { 


    # Method returns dictionary of  web methods declared on class
    [Dictionary[[httpMethod],[String]]] GetWebMethods() {

        # initialize dictionary
        $dict = [Dictionary[[httpMethod],[String]]]::new()
        
        # iterate through each class method, where custom attributes are defined.
        $this.GetType().GetMethods().Where{$_.CustomAttributes}.ForEach{
            
            $methodName = $_.name
            $WebAttribute = $_.CustomAttributes

            # Mapping declared methods to enum values.
            switch($WebAttribute) {
                {$_.TypedValue -eq '"GET"'} {$httpMethod = [httpMethod]::GET } 
                {$_.TypedValue -eq '"POST"'} {$httpMethod = [httpMethod]::POST } 
                {$_.TypedValue -eq '"DELETE"'} {$httpMethod = [httpMethod]::DELETE } 
                {$_.TypedValue -eq '"PUT"'} {$httpMethod = [httpMethod]::PUT } 
            }

            $dict.Add($httpMethod, $methodName)
            
        }

        return $dict


        



    }

}

class FunctionController : Controller { 


}