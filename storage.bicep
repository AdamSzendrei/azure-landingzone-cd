param stage string = 'dev'

param location string = resourceGroup().location

module storageAccount 'br/public:avm/res/storage/storage-account:0.19.0' = {
  name: 'storageAccountDeployment'
  params: {
    // Required parameters
    name: 'staszendcontracts${stage}v2'
    // Non-required parameters
    kind: 'BlobStorage'
    location: location
    skuName: 'Standard_LRS'
  }
}
