param ApimServiceName string
param environmentValue string

resource namedValues 'Microsoft.ApiManagement/service/namedValues@2021-01-01-preview' = {
  properties: {
    tags: []
    secret: false
    displayName: 'APIM-ENVIRONMENT'
    value: environmentValue
  }
  name: '${ApimServiceName}/Environment'
}
