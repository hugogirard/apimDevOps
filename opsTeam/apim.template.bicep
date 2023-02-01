param apimName string
param location string
param publisherEmail string
param publisherName string

resource apimName_resource 'Microsoft.ApiManagement/service@2020-06-01-preview' = {
  name: apimName
  location: location
  sku: {
    name: 'Developer'
    capacity: 1
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}
