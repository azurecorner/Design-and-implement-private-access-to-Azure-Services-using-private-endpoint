// Creates a virtual network
@description('Azure region of the deployment')
param location string = resourceGroup().location

@description('Name of the virtual network resource')
param virtualNetworkName string

@description('Virtual network address prefix')
param vnetAddressPrefix string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: virtualNetworkName
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }

  }
}

output id string = virtualNetwork.id
output name string = virtualNetwork.name