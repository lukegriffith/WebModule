using module .\splunkproperty.psm1

class Item {
    
    [SplunkProperty(Type="Item")]    
    [String]$Itemname

}

$a = [Item]::new()

$b = $a.gettype()

$b.GetProperties().CustomAttributes


