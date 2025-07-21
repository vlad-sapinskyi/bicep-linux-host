[CmdletBinding()]
param(
)
process {
    # Set subscription ID for 'SimCity Test'
    $subscriptionId = 'd283ae58-8e29-46e8-a99b-1fc767265552'

    # Set Azure context
    $account = az account show | ConvertFrom-Json
    if ($subscriptionId -ne $account.id) {
        az account set --subscription $subscriptionId
    }

    # Get Deployment location
    $deploymentLocation = 'swedencentral'

    # Deploy workload
    $deploymentName = "linux-host"
    $deploymentTemplateFile = ".\bicep\main.bicep"
    $deploymentTemplateParameterFile = ".\bicep\main.bicepparam"
    az deployment sub create --name $deploymentName --location $deploymentLocation --template-file $deploymentTemplateFile --parameters $deploymentTemplateParameterFile
}
