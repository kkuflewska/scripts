#Connect to Azure with an authenticated account
Connect-AzureRmAccount 

#Create resource group
New-AzureRmResourceGroup `
    -Name "PSResGroup" `
    -Location "WestEurope" 

#Set the username and password needed for the administrator account 
$cred = Get-Credential

#Create the VM
New-AzureRmVM `
    -ResourceGroupName "PSResGroup" `
    -Name "LabsVM1" `
    -Location "WestEurope" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNSG" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389 `
    -Credential $cred 

#Resize a VM
#return a list of available sizes
Get-AzureRmVMSize -ResourceGroupName "PSResGroup" -VMName "LabsVM1"
#Resize
$vm = Get-AzureRmVM `
    -ResourceGroupName "PSResGroup" `
    -VMName "LabsVM1" 
$vm.HardwareProfile.VmSize = "Standard_B1s"
Update-AzureRmVM `
    -VM $vm `
    -ResourceGroupName "PSResGroup"

#Connect to the VM
#Create a remote desktop connection with the VM
Get-AzureRmPublicIpAddress `
    -ResourceGroupName "PSResGroup" | Select-Object IpAddress

#Stop a VM
Stop-AzureRmVM `
    -ResourceGroupName "PSResGroup" `
    -Name "LabsVM1" -Force

