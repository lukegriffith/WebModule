using Module ..\Controller.psm1


function Register-Controller{
    [cmdletbinding()]
    Param(
        [Parameter(ParameterSetName="ByModule")]
        [String]$ModuleName,
        [Parameter(ParameterSetName="ByModulePath")]
        [String]$ModulePath,
        [Parameter(ParameterSetName="ByScript")]
        [String]$Script
    )

    Process {

        try {
            [ControllerRegister]::InitializeRegister()
        }
        catch {
            Write-Verbose "Register already initialized."   
        }

        if ($PSCmdlet.ParameterSetName -eq "ByModule") {

            Import-Module -Name $ModuleName
            Get-Command -Module $ModuleName | ForEach-Object -Process {
                [ControllerRegister]::RegisterController($_)
            }
        }
        elseif ($PSCmdlet.ParameterSetName -eq "ByModulePath") {

            $ModulePath = $PSCmdlet.GetUnresolvedProviderPathFromPSPath($ModulePath)
            (Import-Module -Name $ModulePath -PassThru).ExportedCommands.Values | ForEach-Object -Process {
                [ControllerRegister]::RegisterController($_)
            }

        }
        elseif ($PSCmdlet.ParameterSetName -eq "ByScript") {
            [ControllerRegister]::RegisterController((Get-Command $Script))
            
        }
    }
}


