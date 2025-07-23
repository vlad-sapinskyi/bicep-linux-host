param name string

param vnetName string
param subnetName string

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' existing = {
  name: vnetName

  resource subnet 'subnets' existing = {
    name: subnetName
  }
}

output vnetId string = vnet.id
output snetId string = vnet::subnet.id
