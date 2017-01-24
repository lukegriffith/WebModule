

enum httpMethod {
    GET
    PUT
    POST
    DELETE
}


class Web : System.Attribute {

    [string]$Method = "GET"
    [String]$Route


}

class WebBinding : System.Management.Automation.CmdletCommonMetadataAttribute {
    [httpMethod]$Method = [httpMethod]::GET
    [String]$Route

 }

