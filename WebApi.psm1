

class WebData {


    static [String]$Data
}


function Get-Data {

    return "{'Name':'PowerShell Webserver2 v0.1','Data':'$([WebData]::Data)'}"
}


function Push-Data {
    param(
        $Data
    )
    [WebData]::Data = $Data
}