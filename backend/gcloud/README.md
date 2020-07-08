# Google Cloud Instance

## Creation

Created at [instances create](https://console.cloud.google.com/compute/instancesAdd?project=batufo-280915&supportedpurview=project) with config exposed in `./small-instance.sh`.

## Data

- [VM instance details](https://console.cloud.google.com/compute/instancesDetail/zones/us-central1-a/instances/batufo-small?project=batufo-280915&supportedpurview=project)
- external IP: `35.226.246.23`, may need to [reserve static IP address](https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address) (solved via DNS)

## Provision

### Install Node.js

### Connect to machine

Open ssh via _Remote Access_ [here](https://console.cloud.google.com/compute/instancesDetail/zones/us-central1-a/instances/batufo-small?project=batufo-280915&supportedpurview=project&cloudshell=false).
Add public keys into `~/my_authorized` and run:

```sh
#!/bin/sh
cat ~/my_authorized >> ~/.ssh/authorized_keys
```

### Install Deps

```sh
sudo apt install git
```

### Install Node.js

- [instructions](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions)

```sh
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
```

### Install Yarn

- [docs](https://linuxize.com/post/how-to-install-yarn-on-debian-9/)

```sh
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn
```

### Setup Systemd Service

- [docs](https://thomashunter.name/posts/2016-09-27-running-a-node-js-process-on-debian-as-a-systemd-service)
- [better docs?](https://www.axllent.org/docs/view/nodejs-service-with-systemd/)

```sh
sudo vim /lib/systemd/system/batufo.service
```

```systemverilog
[Unit]
Description=batufo-service
After=network.target

[Service]
Environment=PORT=80 DEBUG_COLORS=1 DEBUG='(app|stats|game*):(debug|info|error)'
Type=simple
ExecStart=/usr/bin/node /home/thegamedev10/app/batufo/backend/packages/server/dist/app.js
Restart=on-failure
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=batufo

[Install]
WantedBy=multi-user.target
```

```sh
sudo systemctl daemon-reload
sudo systemctl enable batufo
sudo service batufo start
sudo service batufo status
sudo journalctl -u batufo.service
```

### System Settings

```sh
# cat /etc/timezone --> Etc/UTC
sudo ln -fs /usr/share/zoneinfo/US/Mountain /etc/localtime
sudo dpkg-reconfigure -f noninteractive tzdata
# cat /etc/timezone --> America/Denver
```

### Increasing Allowed Open File Handles

- follow [this post](https://easyengine.io/tutorials/linux/increase-open-files-limit/)
- additionally I ran `ulimit -Sn 500000` since otherwise `ulimit -Sn` kept returning `1024`

## App Install

### First Time

```sh
git clone https://github.com/thlorenz/batufo.git
git checkout master
```

### Each Update

```sh
cd ~/app/batufo
git pull
cd backend
yarn && yarn build
sudo service batufo restart
```

# DNS

- [batufo.space domain management](https://ap.www.namecheap.com/domains/domaincontrolpanel/batufo.space/domain)
- [socket.batufo.space](socket.batufo.space)
