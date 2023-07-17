param directoryName string
param env string = 'test'
param location string = 'Europe'
param sku string = 'Standard'

resource azureADtenant 'Microsoft.AzureActiveDirectory/b2cDirectories@2021-04-01' = {
  name: '${directoryName}${env}.onmicrosoft.com'
  location: location
  sku: {
    name: sku
    tier: 'A0'
  }
  properties: {
    createTenantProperties:{
      countryCode:'PL'
      displayName:'name'
    }
  }
}
