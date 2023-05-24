// Creates a KeyVault with Private Link Endpoint
@description('The Azure Region to deploy the resources into')
param location string

@description('The name of the Key Vault')
param keyvaultName string

resource keyVault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: keyvaultName
  location: location

  properties: {
    createMode: 'default'
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: false
    enableRbacAuthorization: true
    enablePurgeProtection: true
    publicNetworkAccess: 'disabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: subscription().tenantId
  }
}

output id string = keyVault.id