param policyAssignmentId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' existing = {
  name: 'staszendcontractsdevv3'
}

resource exemption 'Microsoft.Authorization/policyExemptions@2022-07-01-preview' = {
  scope: storageAccount
  name: 'Public access allowed'
  properties: {
    description: 'Here we describe the exemption'
    displayName: 'Public access allowed'
    policyAssignmentId: policyAssignmentId
    exemptionCategory: 'Mitigated'
  }
}
