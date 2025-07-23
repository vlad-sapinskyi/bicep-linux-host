using 'main.bicep'

param name = 'linux-host'
param location = 'swedencentral'

param network = {
  vnetName: 'vnet-spoke-simcity-prod-sdc-001'
  vnetRgName: 'rg-spoke-simcity-prod-sdc-001'
  subnetName: 'subnet-simcity-prod-sdc'
}

param credentials = {
  userName: name
  password: readEnvironmentVariable('LINUX_HOST_PASSWORD', '')
  ssh: loadTextContent('../ssh/${name}.pub')
}

param host = {
  name: '001'
  ip: '10.178.195.33'
  vmSize: 'Standard_B2as_v2'
  diskSize: 40
  image: {
    publisher: 'canonical'
    offer: 'ubuntu-24_04-lts'
    sku: 'server'
    version: 'latest'
  }
}
