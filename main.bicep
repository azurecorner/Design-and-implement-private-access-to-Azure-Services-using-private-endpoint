param location string

// Virtual network et subnets  vnet-apps-nonprod-frace-001

// Noms des ressources Virtual network et subnets
var virtualNetworkName = 'vnet-meetup-demo'
var subnetName = 'snet-meetup-demo'
var subnetAddressPrefix = '10.9.33.0/24'
var vnetAddressPrefix = '10.9.0.0/16'

var rgAppsSecurityName = 'rg-meetup-demo'

// Nom du key vault (suffixe "-002" pour la prod puisque "-006" est déjà pris)
var keyVaultName = 'kv-meetup-demo'

var privateEndpoint_KvName = 'pe-apps-kv-meetup-demo'

var privateLinkConnexionService_kvName = 'plcs-apps-kv-meetup-demo'

var privateDnsZonevirtualNetworkLinks_kvName = 'vli-apps-kv-meetup-demo'

// Target : Souscription
targetScope = 'subscription'

// Création des groupes de ressources

module rg_apps_security 'modules/resource_group.bicep' = {
  name: rgAppsSecurityName
  params: {
    location: location
    name: rgAppsSecurityName
  }
}

module keyvault 'modules/key_vault.bicep' = {
  scope: resourceGroup(rgAppsSecurityName)
  name: keyVaultName
  params: {
    location: location
    keyvaultName: keyVaultName

  }

  dependsOn: [
    rg_apps_security
  ]
}

//VNET

module vnet 'modules/vnet.bicep' = {
  scope: resourceGroup(rgAppsSecurityName)
  name: virtualNetworkName
  params: {
    location: location
    virtualNetworkName: virtualNetworkName
    vnetAddressPrefix: vnetAddressPrefix

  }

  dependsOn: [
    rg_apps_security
  ]
}
module subnets 'modules/subnets.bicep' = {
  scope: resourceGroup(rgAppsSecurityName)
  name: subnetName
  params: {

    virtualNetworkName: virtualNetworkName
    subnetName: subnetName
    addressPrefix: subnetAddressPrefix

  }

  dependsOn: [
    vnet
  ]
}

var privateDnsZoneName = 'privatelink.vaultcore.azure.net'
var pvtEndpointDnsGroupName = '${privateEndpoint_KvName}/mydnsgroupname'

module keyvaultPrivateEndpoint 'modules/private_endpoint.bicep' = {
  scope: resourceGroup(rgAppsSecurityName)
  name: privateEndpoint_KvName
  params: {
    location: location
    privateEndpointName: privateEndpoint_KvName
    privateDnsZoneName: privateDnsZoneName
    pvtEndpointDnsGroupName: pvtEndpointDnsGroupName
    virtualNetworkId: vnet.outputs.id
    privateLinkConnexionService_kvName: privateLinkConnexionService_kvName
    privateDnsZonevirtualNetworkLinks_kvName: privateDnsZonevirtualNetworkLinks_kvName
    subnetId: '${vnet.outputs.id}/subnets/${subnetName}'
    privateLinkServiceId: keyvault.outputs.id
  }

  dependsOn: [
    vnet, keyvault
  ]
}