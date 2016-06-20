 class Worker {

    [PSobject]$httpContext
    [string]$httpMethod
    [Uri]$uri

    Worker($context) { $this.httpContext = $context}

    [void]ProcessRequest()
    {
        $this.httpMethod = $this.httpContext.request.HttpMethod
        $this.uri = $this.httpContext.request.url

        $response = @"
<html><body><h1>$($this.httpMethod)</h1>
$($this.uri.tostring())
PowerShell WebServer v1
</body></html>
"@

        [byte[]]$b = [System.Text.Encoding]::utf8.getbytes($response.tostring())
        
               
        $this.httpContext.Response.ContentLength64 = $b.Length         
        $this.httpContext.Response.OutputStream.write($b, 0, $b.Length)

    }

 }