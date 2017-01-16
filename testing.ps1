

Import-Module psweb


Register-Controller -ModulePath .\WebApi.psm1

New-WebServer -port 8082

Get-WebServer | Start-WebServer