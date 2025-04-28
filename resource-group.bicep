targetScope = 'subscription'

@description('The location of the resource group.')
param location string = 'switzerlandnorth'

param stage string = 'dev'

resource group 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'rg-aszend-${stage}'
  location: location
  tags: {
    stage: stage
    project: 'course-management'
    'hidden-title' : 'Course Management'
  }
}
