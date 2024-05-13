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
        fileUris = @('https://raw.githubusercontent.com/mate-academy/azure_samples/main/7-azure-vm-advanced/vm-extention-sample-script.sh'); 
        commandToExecute = './vm-extention-sample-script.sh'
    }
    
}    
Set-AzVMExtension @Params

# Get the extention status 
Get-AzVMExtension -ResourceGroupName "vm-availability-demo" -VMName "vm-1" -Name 'CustomScript'
    