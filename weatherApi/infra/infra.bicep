param location string

var aspName = 'appplan-${uniqueString(resourceGroup().id)}'
var webappname = 'webapp-${uniqueString(resourceGroup().id)}'

resource appPlanName 'Microsoft.Web/serverfarms@2018-02-01' = {
  name: aspName
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource web 'Microsoft.Web/sites@2018-11-01' = {
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
  }
}

output webAppname string = webappname
output url string = 'https://${web.properties.hostNames[0]}'
