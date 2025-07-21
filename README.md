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
