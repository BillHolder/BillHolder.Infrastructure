targetScope = 'subscription'

param rgLocation string = 'westeurope'
param resourceGroupName string = 'billholderrg'
param cosmosDbAccountName string = 'billsdbaccount'
param blobStorageAccountName string = 'billsblobsa'
param blobStorageName string = 'bills'
param containerName string = 'billscosmoscontainer'
param databaseName string = 'bills'

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: rgLocation
}

module cosmosDb './database.bicep' = {
  name: cosmosDbAccountName
  scope: resourceGroup(resourceGroupName)
  dependsOn: [rg]
  params:{
    cosmosDbAccountName : cosmosDbAccountName
    location : rgLocation
    containerName : containerName
    databaseName : databaseName
  }
}

module blobStorage './blob_storage.bicep' ={
  name: blobStorageAccountName
  scope: resourceGroup(resourceGroupName)
  dependsOn: [rg]
  params:{
    blobStorageAccountName : blobStorageAccountName
    location : rgLocation
    blobStorageContainerName : containerName
    blobStorageName : blobStorageName
  }
}
