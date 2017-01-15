using Module ./Modules/psweb/Controller.psm1

[ControllerRegister]::InitializeRegister()
[ControllerRegister]::RegisterController([Controller]::new())

$a = [ControllerRegister]::GetRegister()

$a.Get("Controller").Post("Testing")
$a.Get("Controller").Get()