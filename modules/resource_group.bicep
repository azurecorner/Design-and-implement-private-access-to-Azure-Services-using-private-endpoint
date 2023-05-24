param name string
param location string

targetScope = 'subscription'

resource resource_group_gflux 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
}
