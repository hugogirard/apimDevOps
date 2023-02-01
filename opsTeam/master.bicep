targetScope = 'subscription'

@description('Base URL of the repository')
param repoBaseUrl string

@description('The name of the resource group')
param rgName string

@description('The location of all resources')
param location string = 'eastus'

@description('The publisher email')
param publisherEmail string

@description('The publisher name')
param publisherName string

@description('The named value environment')
param environmentValue string

var apimName = 'apim-${environmentValue}-${uniqueString(rg.id)}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module apim 'apim.template.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'apim'  
  params: {
    apimName: apimName
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

module products 'apim.products.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'products'
  params: {
    ApimServiceName: apimName
  }
  dependsOn: [
    apim
  ]
}

module namedValue 'namedValues.template.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'namedValue'
  params: {
    ApimServiceName: apimName
    environmentValue: environmentValue
  }
  dependsOn: [
    apim
  ]
}

module globalPolicy 'policy/global.policy.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'globalPolicy'
  params: {
    ApimServiceName: apimName
    BaseUrl: repoBaseUrl
  }
  dependsOn: [
    apim
    namedValue
  ]
}

output apiManegementName string = apimName
