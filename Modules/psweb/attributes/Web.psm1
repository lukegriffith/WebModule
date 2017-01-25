<#
    Web.psm1

    .Synopsis
        Class file for Web attributes, these are used on framework controllers.

    .Notes
        Date: 24/01/2017
        Author: Luke Griffith
#>

enum httpMethod {
    GET
    PUT
    POST
    DELETE
}

class WebAttribute : System.Attribute {

    [string]$Method = "GET"
    [String]$Route


}

class WebBinding : System.Management.Automation.CmdletCommonMetadataAttribute {
    [httpMethod]$Method = [httpMethod]::GET
    [String]$Route

 }

