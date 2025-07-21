targetScope = 'subscription'

param name string
param location string

param network object
param credentials object
param host object

var rgName = 'rg-${name}'

module networkModule 'modules/network.bicep' = {
  name: 'module-network-${name}'
  scope: resourceGroup(network.vnetRgName)
  params: {
    name: name
    vnetName: network.vnetName
    subnetAddressPrefix: network.subnetAddressPrefix
  }
}

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: rgName
  location: location
  dependsOn: [
    networkModule
  ]
}

module hostsModule 'modules/host.bicep' = {
  name: 'module-host-${name}-${host.name}'
  scope: resourceGroup(rgName)
  dependsOn: [
    rg
  ]
  params: {
    name: name
    instance: host.name
    location: location
    subnetId: networkModule.outputs.snetId
    privateIp: host.ip
    vmSize: host.vmSize
    diskSize: host.diskSize
    image: host.image
    userName: credentials.userName
    password: credentials.ssh
  }
}
