<#

    .Description
    Function is used to abstract the response to the requester. WebServer passes this off to lower functions to process the request.
    This will eventually hand over to a MVC framework that will handle binding and controllers, and mapping things like parameters to functions.


    Fun parts of $Context

    $Context.Request.Url
    $Context.Request.UserAgent
    $Context.Request.HttpMethod
    $Context.Request.QueryString (Array of keys sent in URL)
    $Context.Request.RawUrl (Keys and values sent.. Potentially the full URI after the name.)

    (Assume this is the body)
    $Response.Request.InputStream 
    of type
    System.IO.Stream+NullStream
    (Read gives bytes? ) 

    .Notes
        Change Log:
        20/07/2016 - Created by Luke Griffith


#>
function Initialize-Response {
    param(
        [System.Net.HttpListenerContext]$Context
    )

    $reply = @"
{'Name':'PowerShell Webserver2 v0.1'}  
"@

    [byte[]]$b = [System.Text.Encoding]::utf8.getbytes($reply.tostring())

           
    $Context.Response.ContentLength64 = $b.Length         
    $Context.Response.OutputStream.write($b, 0, $b.Length)


}
