using Namespace System.Net;
using Namespace System.Management.Automation;
using Namespace System.Management.Automation.Runspaces;
using Namespace System.Collections.Generic;
using Namespace System.Collections;
using Namespace System.Runtime;
using Module ..\Controller.psm1


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
function Read-Context {
    param(
        [System.Net.HttpListenerContext]$Context
    )
    

    $Register = Get-Register 
    $controller = $Register.Get($Context.Request.Url.Segments[1])

    $controller.SetCurrentContext($Context)

    $method = $controller.gettype().GetMethods().Where{$_.Name -eq $Context.request.HttpMethod}

    $ParamArray = @()

    if ($Context.Request.url.Query){

        $QueryDict = $Context.Url.Query.replace("?","").split("&") | convertfrom-stringdata

        $method.GetParameters() | Sort-Object -Property Position |
        ForEach-Object {
            if ($QueryDict.ContainsKey($_.Name)){

                $ParamArray.Add($QueryDict[$_.Name])

            }

            else {

                $ParamArray.Add($Null)

            }

        }

    }

    $reply = $method.Invoke($controller, $ParamArray)

    if ($method.ReturnType -eq [System.String]){

        [byte[]]$b = [System.Text.Encoding]::utf8.getbytes($reply.tostring())

        $Context.Response.ContentLength64 = $b.Length

        $Context.Response.OutputStream.write($b, 0, $b.Length)
    }
    else {
        $Context.Response.OutputStream.Close()
    }
}
