param name string
param instance string
param location string

param subnetId string
param privateIp string
param publicIpId string
param vmSize string
param diskSize int
param image object
param allowedPorts object[]

@secure()
param userName string
@secure()
param password string

var nsgName = 'nsg-${name}-${instance}'
var nicName = 'nic-${name}-${instance}'
var vmName = 'vm-${name}-${instance}'
var diskName = 'disk-${name}-${instance}'

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      for port in allowedPorts: {
        name: 'AllowInBoundPort${port.number}'
        properties: {
          priority: port.priority
          protocol: port.protocol
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: port.number
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ip-config'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Static'
          privateIPAddressVersion: 'IPv4'
          privateIPAddress: privateIp
          publicIPAddress: {
            id: publicIpId
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      osDisk: {
        name: diskName
        diskSizeGB: diskSize
        createOption: 'FromImage'
        deleteOption: 'Delete'
      }
      imageReference: image
    }
    osProfile: {
      computerName: instance
      adminUsername: userName
      adminPassword: password
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${userName}/.ssh/authorized_keys'
              keyData: password
            }
          ]
        }
      }
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
