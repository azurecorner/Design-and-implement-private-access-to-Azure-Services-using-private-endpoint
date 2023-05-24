// Creates a KeyVault with Private Link Endpoint
@description('The Azure Region to deploy the resources into')
param location string 
param privateEndpointName string
param privateDnsZoneName string

param pvtEndpointDnsGroupName string 
param virtualNetworkId string
param subnetId string
param privateLinkServiceId string
param privateLinkConnexionService_kvName string
param privateDnsZonevirtualNetworkLinks_kvName string
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: privateLinkConnexionService_kvName
        properties: {
          privateLinkServiceId: privateLinkServiceId
          groupIds: [
            'vault'
          ]
        }
      }
    ]
  }
 
}



resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZoneName
  location: 'global'
  properties: {}
 
}




resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZone
  name: privateDnsZonevirtualNetworkLinks_kvName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource pvtEndpointDnsGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-05-01' = {
  name: pvtEndpointDnsGroupName
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZone.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoint
  ]
}

