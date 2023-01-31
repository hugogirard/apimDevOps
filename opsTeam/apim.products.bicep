param ApimServiceName string

resource ApimServiceName_free_api 'Microsoft.ApiManagement/service/products@2021-01-01-preview' = {
  properties: {
    description: 'Some free APIs from our company'
    subscriptionRequired: true
    approvalRequired: false
    state: 'published'
    displayName: 'Free API'
  }
  name: '${ApimServiceName}/free-api'
}

resource ApimServiceName_free_api_administrators 'Microsoft.ApiManagement/service/products/groups@2021-01-01-preview' = {
  parent: ApimServiceName_free_api
  properties: {
    description: 'Administrators is a built-in group. Its membership is managed by the system. Microsoft Azure subscription administrators fall into this group.'
    displayName: 'Administrators'
    type: 'system'
    builtIn: true
  }
  name: 'administrators'
}