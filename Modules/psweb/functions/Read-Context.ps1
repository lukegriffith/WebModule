using Namespace System.Net;
using Namespace System.Management.Automation;
using Namespace System.Management.Automation.Runspaces;
using Namespace System.Collections.Generic;
using Namespace System.Collections;
using Namespace System.Runtime;


<#

    .Description
    Function is used to abstract the response to the requester. WebServer passes this off to lower functions to process the request.
    This will eventually hand over to a MVC framework that will handle binding and apiFunctions, and mapping things like parameters to functions.


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
    

    $Request = $Context.Request

    $Register = Get-Register 
    $apiFunction = $Register.Get($Request.Url.Segments[1])

    #$apiFunction.SetCurrentContext($Context)

    $paramDict = @{}

    if ($apiFunction.Parameters){

        $QueryDict = $Request.Url.Query.replace("?","").split("&") | convertfrom-stringdata

        $apiFunction.Parameters.Keys | ForEach-Object -Process {
            if ($QueryDict.ContainsKey($_)){

                if ($_ -eq "context") {
                    $paramDict[$_] = $Context
                }
                else {
                    $paramDict[$_] = $QueryDict[$_]
                }
            }
            elseif ($apiFunctions.Parameters[$_].Attributes.Mandatory) {
                Throw "Unable to process, mandatory parameters missing."
            }


        }

    }

    $reply = & $apiFunction @paramDict

    if ($reply) {
        [byte[]]$b = [System.Text.Encoding]::utf8.getbytes($reply.tostring())
        $Context.Response.ContentLength64 = $b.Length
        $Context.Response.OutputStream.write($b, 0, $b.Length)
    }
    else {
        $Context.Response.Close()
    }
}
