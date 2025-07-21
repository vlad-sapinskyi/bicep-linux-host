param name string

param vnetName string
param subnetAddressPrefix string

var subnetName = 'snet-${name}'

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' existing = {
  name: vnetName

  resource subnet 'subnets' = {
    name: subnetName
    properties: {
      addressPrefix: subnetAddressPrefix
    }
  }
}

output vnetId string = vnet.id
output snetId string = vnet::subnet.id
