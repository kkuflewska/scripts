param(
    [Parameter(Mandatory=$true)]
    [string] $TemplateFilePath,
    [Parameter(Mandatory=$true)]
    [string] $TemplateParameterFilePath,
    [Parameter(Mandatory=$true)]
    [string] $DeploymentName,
    [Parameter(Mandatory=$true)]
    [string] $Location
)

$ErrorActionPreference = "Stop"
if ((Test-Path $TemplateFilePath) -and (Test-Path $TemplateParameterFilePath)) {
    New-AzureRmDeployment -Location $Location -Name $DeploymentName -TemplateFile $TemplateFilePath -TemplateParameterFile $TemplateParameterFilePath
} else {
    Write-Error "One of required files was not found"
}