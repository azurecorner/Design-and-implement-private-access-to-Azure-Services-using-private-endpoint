

@description('Name of the virtual network resource')
param virtualNetworkName string

@description('Name of the virtual network resource')
param subnetName string

@description('Subnet address prefix')
param addressPrefix string 

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
  name: '${virtualNetworkName}/${subnetName}'
  properties: {
    addressPrefix: addressPrefix
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
  }
}
