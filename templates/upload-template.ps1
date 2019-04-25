$resourceGroupName = "anotherResGroup"
$location = "West Europe"

#New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzureRmResourceGroupDeployment `
    -TemplateFile .\Create-ResourceGroup.json