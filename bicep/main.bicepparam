using 'main.bicep'

param name = 'linux-host'
param location = 'swedencentral'

param network = {
  vnetAddressPrefix: '172.16.0.0/16'
  subnetAddressPrefix: '172.16.0.0/24'
}

param credentials = {
  userName: name
  password: readEnvironmentVariable('LINUX_HOST_PASSWORD', '')
  ssh: loadTextContent('../ssh/ssh-${name}.pub')
}

param host = {
  name: '001'
  ip: '172.16.0.11'
  vmSize: 'Standard_B2as_v2'
  diskSize: 40
  image: {
    publisher: 'canonical'
    offer: 'ubuntu-24_04-lts'
    sku: 'server'
    version: 'latest'
  }
}
