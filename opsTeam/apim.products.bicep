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
  name: 'administrators'
}
