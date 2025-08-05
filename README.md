# bicep-linux-host

IaC for deploying Linux host

## 1. Generate new SSH key-pair

```ssh-keygen -b 2048 -t rsa -C linux-host -f .\ssh\linux-host```

## 2. Grant policy permissions

```$path = "[path to .pem file]"```

```icacls.exe $path /reset```

```icacls.exe $path /GRANT:R "$($env:USERNAME):(R)"```

```icacls.exe $path /inheritance:r```

## 3. Set the 'LINUX_HOST_PASSWORD' environment variable

```$env:LINUX_HOST_PASSWORD = '[custom user password]'```

## 4. Run the deployment

```.\scripts\Deploy-Host.ps1```

## 5. Install GUI

```sudo apt update && sudo apt upgrade -y```

```sudo apt install ubuntu-desktop -y```


sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install xfce4
sudo apt install xfce4-session


## 6. Install XRDP

```sudo apt install xrdp -y```

```sudo systemctl enable xrdp```

```sudo adduser xrdp ssl-cert```

```echo xfce4-session >~/.xsession```

```sudo systemctl restart xrdp```

## 7. Add new user

```sudo useradd -m vlds --shell /bin/bash```

```sudo passwd vlds```

```sudo usermod -aG sudo vlds```
