param stage string = 'dev'

param location string = resourceGroup().location

module storageAccount 'br/public:avm/res/storage/storage-account:0.19.0' = {
  name: 'storageAccountDeployment'
  params: {
    // Required parameters
    name: 'staszendcontracts${stage}v4'
    // Non-required parameters
    kind: 'BlobStorage'
    location: location
    skuName: 'Standard_LRS'
    minimumTlsVersion: 'TLS1_2'
  }
}

var policyToAssign = '/providers/Microsoft.Authorization/policyDefinitions/b2982f36-99f2-4db5-8eff-283140c09693'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2025-01-01' = {
  name: 'Storage account disable public network access'
  properties: {
    #disable-next-line use-resource-id-functions
    policyDefinitionId: policyToAssign
    parameters: {
      effect: { value: 'Audit' }
    }
  }
}
