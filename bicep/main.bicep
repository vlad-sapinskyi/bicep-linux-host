targetScope = 'subscription'

param name string
param location string

param network object
param credentials object
param host object

var rgName = 'rg-${name}'

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: rgName
  location: location
}

module networkModule 'modules/network.bicep' = {
  name: 'module-network-${name}'
  scope: rg
  params: {
    name: name
    location: location
    vnetAddressPrefix: network.vnetAddressPrefix
    subnetAddressPrefix: network.subnetAddressPrefix
  }
}

module hostsModule 'modules/host.bicep' = {
  name: 'module-host-${name}-${host.name}'
  scope: resourceGroup(rgName)
  params: {
    name: name
    instance: host.name
    location: location
    subnetId: networkModule.outputs.subnetId
    privateIp: host.ip
    publicIpId: networkModule.outputs.publicIpId
    vmSize: host.vmSize
    diskSize: host.diskSize
    image: host.image
    allowedPorts: [
      {
        number: '22'
        priority: 1000
        protocol: 'Tcp'
      }
    ]
    userName: credentials.userName
    password: credentials.ssh
  }
}
