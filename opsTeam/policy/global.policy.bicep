param ApimServiceName string
param BaseUrl string

resource ApimServiceName_policy 'Microsoft.ApiManagement/service/policies@2021-01-01-preview' = {
  properties: {
    value: '${BaseUrl}/policy/global.xml'
    format: 'rawxml-link'
  }
  name: '${ApimServiceName}/policy'
}