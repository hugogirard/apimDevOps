param ApimServiceName string
param WebUrl string

resource ApimServiceName_fibonacci 'Microsoft.ApiManagement/service/apis@2022-04-01-preview' = {  
  name: '${ApimServiceName}/fibonacci'
  properties: {
    apiRevision: '2'
    isCurrent: true
    subscriptionRequired: true
    displayName: 'Fibonacci'    
    format: 'openapi+json'
    value: loadTextContent('./apiDefinition.yaml')
    serviceUrl: WebUrl
    path: 'Fibo'
    protocols: [
      'https'
    ]
  }  
  dependsOn: []
}
