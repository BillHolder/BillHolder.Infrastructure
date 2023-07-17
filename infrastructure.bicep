targetScope = 'subscription'

@allowed([
  'test'
  'staging'
  'production'
])
param env string = 'test'
@allowed([
  'westeurope'
])
param rgLocation string = 'westeurope'
param resourceGroupName string = 'billholderrg'
param cosmosDbAccountName string = 'billsdbaccount'
param blobStorageAccountName string = 'billsblobsa'
param b2cAccountName string = 'billsbbc'
param b2cDirectory string = 'billsdirectory'
param containerName string = 'billscosmoscontainer'
param databaseName string = 'bills'
param activeDirectoryLocation string = 'Europe'

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: rgLocation
}

module cosmosDb './Bills/database.bicep' = {
  name: cosmosDbAccountName
  scope: resourceGroup(resourceGroupName)
  dependsOn: [rg]
  params:{
    cosmosDbAccountName : cosmosDbAccountName
    location : rgLocation
    containerName : containerName
    databaseName : databaseName
    env : env
  }
}

module blobStorage './Bills/blob_storage.bicep' ={
  name: blobStorageAccountName
  scope: resourceGroup(resourceGroupName)
  dependsOn: [rg]
  params:{
    blobStorageAccountName : blobStorageAccountName
    location : rgLocation
    env : env
  }
}

module activeDirectoryB2C './Users/active_directory.bicep' ={
  name: b2cAccountName
  scope: resourceGroup(resourceGroupName)
  dependsOn: [rg]
  params:{
    directoryName: b2cDirectory
    location : activeDirectoryLocation
    env : env
  }
}
