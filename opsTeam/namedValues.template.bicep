param ApimServiceName string
param environmentValue string

resource ApimServiceName_Environment 'Microsoft.ApiManagement/service/namedValues@2021-01-01-preview' = {
  properties: {
    tags: []
    secret: false
    displayName: 'APIM-ENVIRONMENT'
    value: environmentValue
  }
  name: '${ApimServiceName}/Environment'
}