# PowerShell Web Module
PowerShell framework for publishing modules build around .NET HTTPListener API. 
Easily register all exported module functions as web methods with parameter binding and local module data available. 

# Recently Added
- Extend webserver with PowerShell modules. Exported functions become WebMethods 
- Use classes to store data locally to the module.

Setup API

    Import-Module psweb
    Register-Controller -ModulePath .\WebApi.psm1

    New-WebServer -port 8082
    Get-WebServer | Start-WebServer

Example of using web methods. 

    PS C:\Users\lukem\Documents\GitHub\psweb> irm -uri "http://localhost:8082/get-data"

    Name                       Data
    ----                       ----
    PowerShell Webserver2 v0.1


    PS C:\Users\lukem\Documents\GitHub\psweb> irm -uri "http://localhost:8082/push-data?Data=thisismine"

    PS C:\Users\lukem\Documents\GitHub\psweb> irm -uri "http://localhost:8082/get-data"

    Name                       Data
    ----                       ----
    PowerShell Webserver2 v0.1 thisismine
