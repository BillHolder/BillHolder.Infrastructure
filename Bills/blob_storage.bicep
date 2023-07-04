param location string = resourceGroup().location
param blobStorageAccountName string
param blobStorageName string
param blobStorageContainerName string

resource billsStorageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: blobStorageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'None'
  }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
  }
}

resource billsBlobStorage 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01'={
  name: 'default'
  parent: billsStorageAccount
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = { 
  parent: billsBlobStorage
  name: blobStorageContainerName
}
