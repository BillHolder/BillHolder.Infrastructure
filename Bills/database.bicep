param cosmosDbAccountName string
param location string = resourceGroup().location
param env string

@description('The name for the SQL API database')
param databaseName string

@description('The name for the SQL API container')
param containerName string

resource account 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' = {
  name: '${toLower(cosmosDbAccountName)}${env}'
  location: location
  properties: {
    enableFreeTier: true
    databaseAccountOfferType: 'Standard'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
      }
    ]
  }
}

resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2022-05-15' = {
  parent: account
  name: '${databaseName}${env}'
  properties: {
    resource: {
      id: '${databaseName}${env}'
    }
    options: {
      throughput: 1000
    }
  }
}

resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2022-05-15' = {
  parent: database
  name: '${containerName}${env}'
  properties: {
    resource: {
      id: '${containerName}${env}'
      partitionKey: {
        paths: [
          '/myPartitionKey'
        ]
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/_etag/?'
          }
        ]
      }
    }
  }
}
