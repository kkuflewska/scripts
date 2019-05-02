param(
 [Parameter(Mandatory=$true)]
 [string] $TemplateFilePath,

 [Parameter(Mandatory=$true)]
 [string] $ParametersFilePath,

 [Parameter(Mandatory=$True)]
 [string] $resourceGroupName,

 [Parameter(Mandatory=$True)]
 [string] $resourceGroupLocation,

 [Parameter(Mandatory=$True)]
 [string] $DeploymentName
)


$ErrorActionPreference = "Stop"

#Create or check for existing resource group
$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if(!$resourceGroup)
{
    Write-Host "Resource group '$resourceGroupName' does not exist. To create a new resource group, please enter a location.";
    if(!$resourceGroupLocation) {
        $resourceGroupLocation = Read-Host "resourceGroupLocation";
    }
    Write-Host "Creating resource group '$resourceGroupName' in location '$resourceGroupLocation'";
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation
}
else{
    Write-Host "Using existing resource group '$resourceGroupName'";
}

# Start the deployment
Write-Host "Starting deployment...";
if ((Test-Path $TemplateFilePath) -and (Test-Path $ParametersFilePath)) {
    New-AzureRmDeployment `
    -Name $DeploymentName `
    -Location $resourceGroupLocation `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParametersFilePath
} else {
    Write-Error "One of required files was not found"
}