param name string
param location string

param vnetAddressPrefix string
param subnetAddressPrefix string

var vnetName = 'vnet-${name}'
var subnetName = 'snet-${name}'
var ipName = 'ip-${name}'

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }

  resource subnet 'subnets' existing = {
    name: subnetName
  }
}

resource ip 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: ipName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  zones: []
}

output subnetId string = vnet::subnet.id
output publicIpId string = ip.id
