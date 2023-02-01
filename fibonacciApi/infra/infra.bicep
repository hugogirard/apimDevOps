param location string

var appServicePlanName = 'asp-${uniqueString(resourceGroup().id)}'
var webappname = 'web-${uniqueString(resourceGroup().id)}'

resource appPlanName 'Microsoft.Web/serverfarms@2018-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource webAppName 'Microsoft.Web/sites@2022-03-01' = {
  name: webappname
  location: location
  properties: {    
    serverFarmId: appPlanName.id
    siteConfig: {
      netFrameworkVersion: 'v7.0'
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnet'
        }
      ]
    }
    httpsOnly: true
  }
}

output webAppname string = webappname
output url string = 'https://${webAppName.properties.hostNames[0]}'
