# PowerShell Web Module
Publish powershell modules to a local webAPI, registering all exported module functions as web methods with parameter binding and local module data available. 

# Recently Added

- Extend webserver with PowerShell modules. Exported functions become API's 
- Use classes to store data locally to the module.



![ShellView](https://i.imgur.com/1TntdAw.jpg) 


    PS C:\Users\lukem\Documents\GitHub\psweb> irm -uri "http://localhost:8082/get-data"

    Name                       Data
    ----                       ----
    PowerShell Webserver2 v0.1


    PS C:\Users\lukem\Documents\GitHub\psweb> irm -uri "http://localhost:8082/push-data?Data=thisismine"

    PS C:\Users\lukem\Documents\GitHub\psweb> irm -uri "http://localhost:8082/get-data"

    Name                       Data
    ----                       ----
    PowerShell Webserver2 v0.1 thisismine
