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

module apimTemplate 'apim.template.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'apimTemplate'  
  params: {
    apimName: apimName
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

module productTemplate 'apim.products.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'productTemplate'
  params: {
    ApimServiceName: apimName
  }
  dependsOn: [
    apimTemplate
  ]
}

module namedValueTemplate 'namedValues.template.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'namedValueTemplate'
  params: {
    ApimServiceName: apimName
    environmentValue: environmentValue
  }
  dependsOn: [
    apimTemplate
  ]
}

module globalPolicyTemplate 'policy/global.policy.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'globalPolicyTemplate'
  params: {
    ApimServiceName: apimName
    BaseUrl: repoBaseUrl
  }
  dependsOn: [
    apimTemplate
    namedValueTemplate
  ]
}

output apiManegementName string = apimName
