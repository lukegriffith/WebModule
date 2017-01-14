using namespace System.Collections.Generic
using namespace System.Net
using Module .\Controller.psm1


[RegisterController]::InitializeRegister()
[RegisterController]::Register(
    [Controller]::new()
)


# Loading functions
Get-ChildItem $PSScriptRoot -Recurse -Filter "*.ps1" | ForEach-Object -Process {
    .  $_.fullname
}

