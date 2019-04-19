Param(
    [Parameter(Mandatory=$true)]
    [String] 
    $VMName, 

    [Parameter(Mandatory=$true)]
    [String] 
    $ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [String] 
    $location
)

# Connect to Azure with an authenticated account
Connect-AzureRmAccount 

# Check if the resource group already exists
$exists = Get-AzureRmResourceGroup `
    -ResourceGroupName $ResourceGroupName 
if ($exists) {
    Write-Host "Resource group already exists"
}
else {
    Write-Host "Create new resource group"
    
    New-AzureRmResourceGroup `
        -Name $ResourceGroupName `
        -Location $location 
}

# Check if the VM already exists
$exists = Get-AzureRmVm `
    -ResourceGroupName $ResourceGroupName `
    -VMName $VMName
if ($exists) {
    Write-Error "A VM named $VMName already exists"
}
else {
    # Set the username and password needed for the administrator account 
    $cred = Get-Credential

    # Create the VM
    New-AzureRmVM `
     -ResourceGroupName $ResourceGroupName `
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
     -ResourceGroupName $ResourceGroupName `
     -VMName $VMName 
    $vm.HardwareProfile.VmSize = "Standard_B1s"
    Update-AzureRmVM `
     -VM $vm `
     -ResourceGroupName $ResourceGroupName

    # Stop a VM
    Stop-AzureRmVM `
     -ResourceGroupName $ResourceGroupName `
     -Name $VMName -Force
}