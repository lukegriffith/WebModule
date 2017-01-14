using Module .\Controller.psm1


[ControllerRegister]::InitializeRegister()
[ControllerRegister]::RegisterController(
    [Controller]::new()
)


# Loading functions
Get-ChildItem $PSScriptRoot -Recurse -Filter "*.ps1" | ForEach-Object -Process {
    .  $_.fullname
}

