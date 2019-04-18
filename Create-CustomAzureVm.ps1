Param(
    [Parameter(Mandatory=$true)]
    [String] 
    $VMName, 

    [Parameter(Mandatory=$true)]
    [String] 
    $resourceGroupName,

    [Parameter(Mandatory=$true)]
    [String] 
    $location
)

# Connect to Azure with an authenticated account
Connect-AzureRmAccount 

# Create resource group
New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $location 

# Set the username and password needed for the administrator account 
$cred = Get-Credential

# Create the VM
New-AzureRmVM `
    -ResourceGroupName $resourceGroupName `
    -Name $VMName `
    -Location $location `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNSG" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389 `
    -Credential $cred 

# Resize a VM
$vm = Get-AzureRmVM `
    -ResourceGroupName $resourceGroupName `
    -VMName $VMName 
$vm.HardwareProfile.VmSize = "Standard_B1s"
Update-AzureRmVM `
    -VM $vm `
    -ResourceGroupName $resourceGroupName

# Stop a VM
Stop-AzureRmVM `
    -ResourceGroupName $resourceGroupName `
    -Name $VMName -Force