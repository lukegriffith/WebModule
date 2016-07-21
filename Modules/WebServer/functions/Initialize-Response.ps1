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
<#

Response.Request has  --- 

 $Response.Request.Url
$Response.Request.UserAgent
HttpMethod
QueryString (Array of keys sent in URL)
RawUrl (Keys and values sent)

(Assume this is the body)
$Response.Request.InputStream 
System.IO.Stream+NullStream
(Read gives bytes? ) 



#>