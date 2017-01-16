# psWeb

Started again on PowerShell [WebServer](https://github.com/lukemgriffith/webServer) I started over a year ago. Trying to break down and make a hardier solution than I had before.

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
