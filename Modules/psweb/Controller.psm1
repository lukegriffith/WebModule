using namespace System.Management.Automation
using namespace System.Collections.Generic
using namespace System.Net

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
