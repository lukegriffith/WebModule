using Module ..\Controller.psm1

function Get-Register {

    return [ControllerRegister]::GetRegister()
}