param ApimServiceName string
param WebUrl string


resource ApimServiceName_WeatherApi 'Microsoft.ApiManagement/service/apis@2021-01-01-preview' = {
  name: '${ApimServiceName}/WeatherApi'
  properties: {    
    apiRevision: '1'
    isCurrent: true
    subscriptionRequired: true
    displayName: 'WeatherApi Canada'
    serviceUrl: WebUrl
    format: 'openapi+json'
    value: loadTextContent('./apiDefinition.yaml')    
    path: 'weather'
    protocols: [
      'https'
    ]
  }
  
  dependsOn: []
}

// resource ApimServiceName_free_api_weatherapi 'Microsoft.ApiManagement/service/products/apis@2021-01-01-preview' = {
//   name: '${ApimServiceName}/free-api/weatherapi'
//   dependsOn: []
// }
