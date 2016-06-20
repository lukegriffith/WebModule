using namespace System.Net;


function CreateListener {
    param(
        $prefix
    )

    $http = [HttpListener]::new()
    $http.Prefixes.Add($prefix)
    $http.Start()
        
    return $http 

}

