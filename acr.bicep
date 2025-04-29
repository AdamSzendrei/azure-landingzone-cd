@description('The location of the resource group.')
//param location string = 'switzerlandnorth'

param stage string = 'dev'

param user1 string 
param user2 string 

param location string = resourceGroup().location
param projectName string
//param tags object
//param adminPrincipalId string

var abbrs = loadJsonContent('abbreviations.json')
var roles = loadJsonContent('azure-roles.json')

// Create container registry
resource registry 'Microsoft.ContainerRegistry/registries@2024-11-01-preview' = {
  name: '${abbrs.containerRegistryRegistries}${uniqueString(projectName)}'
  location: location
  sku: {
    name: 'Basic' // Choose a different SKU if needed.
                  // Consider making this a parameter if you need more flexibility.
  }
  properties: {}
}

resource registryPushAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(registry.name, user1, 'push')
  scope: registry
  properties: {
    principalId: user1
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roles.AcrPush)
  }
}

resource registryPullAssignment1 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(registry.name, user1, 'pull')
  scope: registry
  properties: {
    principalId: user1
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roles.AcrPull)
  }
}

resource registryPullAssignment2 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(registry.name, user2, 'pull')
  scope: registry
  properties: {
    principalId: user2
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roles.AcrPull)
  }
}

