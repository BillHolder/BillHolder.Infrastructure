targetScope = 'subscription'

param rgLocation string = 'westeurope'
param resourceGroupName string = 'billHolderSubscription'
param cosmosDbAccountName string = 'billsDbAccount'
param containerName string = 'billsCosmosContainer'
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
