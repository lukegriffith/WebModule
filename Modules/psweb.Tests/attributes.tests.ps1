using module ..\psweb\attributes\Web.psm1



class Host {

    
    [Web(Method="BLAr",Route='api/Host')]
    [String]GetItem(){
        return '{"items":1}'
    }

    [Web(Method="GET",Route='api/Host')]
    [string]$Name
}


function Get-DataCollection {
    [WebBinding(Method='GET', Route='api/Host/DataCollection')]
    param(
        [string]$Host
    )
}






Describe "Testing attributes" {

    
    Context "Host tests" {

        it "Host exists" {

            [Host] | should be $true
        }

        
        it "Host property 'Name' has web attribute" {

            [Host].GetProperties().Where{$_.Name -eq "Name"}.CustomAttributes | should be $true

        }

        it "Host method 'GetItem()' has web attribute" {

            [Host].GetMethods().Where{$_.Name -eq "GetItem"}.CustomAttributes | should be $true

        }


    }



    Context "Command tests" {

        it "Command is defined" {
    
            gcm Get-DataCollection | Should be $true
        }
    
    
        it "Command has attribute" {
    
            $cmd = gcm Get-DataCollection
    
            $cmd.ScriptBlock.Attributes | should be $true
    
        }
    
    
    }



}


