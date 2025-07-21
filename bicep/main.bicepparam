using 'main.bicep'

param name = 'linux-host'
param location = 'swedencentral'

param network = {
  vnetName: 'vnet-spoke-simcity-test-sdc-001'
  vnetRgName: 'rg-spoke-simcity-test-sdc-001'
  subnetAddressPrefix: '10.179.249.0/29'
}

param credentials = {
  userName: name
  password: readEnvironmentVariable('LINUX_HOST_PASSWORD', '')
  ssh: loadTextContent('../ssh/${name}.pub')
}

param host = {
  name: '001'
  ip: '10.179.249.4'
  vmSize: 'Standard_B2as_v2'
  diskSize: 40
  image: {
    publisher: 'canonical'
    offer: 'ubuntu-24_04-lts'
    sku: 'server'
    version: 'latest'
  }
}
