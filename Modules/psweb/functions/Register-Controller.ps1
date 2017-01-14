using Module ..\Controller.psm1


function Register-Controller{


    [ControllerRegister]::InitializeRegister()
    [ControllerRegister]::RegisterController(
        [Controller]::new()
    )


}


