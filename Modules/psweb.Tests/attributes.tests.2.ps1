
class apiObject : System.Attribute {
    [bool]$shouldQuery
}



class Software {

    [apiObject(shouldQuery=$true)]
    [String]$Name

    

}



Describe "Testing attributes" {

    Context "Software tests" {

        
    
        it "Software property 'Name' has web attribute" {
    
            [Software].GetProperties().Where{$_.Name -eq "Name"}.CustomAttributes | should be $true
    
        }
    


    }
}