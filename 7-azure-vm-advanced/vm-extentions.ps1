# Get all available extentions: 
Get-AzVmImagePublisher -Location "uksouth" | 
Get-AzVMExtensionImageType | Get-AzVMExtensionImage | Select-Object Type, PublisherName, Version

# Same, but save to variable so we can load extentions once, and then explore them: 
$extentions =  Get-AzVmImagePublisher -Location "uksouth" | Get-AzVMExtensionImageType | Get-AzVMExtensionImage | Select-Object Type, PublisherName, Version

# Get info about Custom Script Extention: 
$extentions | Where-Object {$_.Type -eq "CustomScript" }

# Install extention on the VM: 
$Params = @{ 
    ResourceGroupName  = "vm-availability-demo"
    VMName             = "vm-1"
    Name               = 'CustomScript' 
    Publisher          = 'Microsoft.Azure.Extensions'
    ExtensionType      = 'CustomScript' 
    TypeHandlerVersion = '2.1' 
    ProtectedSettings  = @{
        fileUris = @('https://m.media-amazon.com/images/I/61CaZ+ZB-wL._UF894,1000_QL80_.jpg'); 
        commandToExecute = 'exit 1'
    }
    
}    
Set-AzVMExtension @Params

# Get the extention status 
Get-AzVMExtension -ResourceGroupName "vm-availability-demo" -VMName "vm-1" -Name 'CustomScript'
    