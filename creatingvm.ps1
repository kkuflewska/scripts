#Set the username and password needed for the administrator account 
$cred = Get-Credential

#Create the VM
New-AzureRmVM `
    -ResourceGroupName "LabResGroup" `
    -Name "LabsVM1" `
    -Size "Standard B1s" `
    -Location "WestEurope" `
    -VirtualNetworkName "LabsResGroup-vnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "LabsVM-nsg" `
    -PublicIpAddressName "myPublicIpAddress" `
    -Credential $cred

