#!/bin/bash

echo "This is my userdata for ${GAMENAME}"

# Install steamcmd and other required components
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
echo steam steam/question select "I AGREE" | debconf-set-selections
echo steam steam/license note '' | debconf-set-selections
apt install steamcmd -y
apt install bsdmainutils bzip2 jq lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0:i386 netcat pigz unzip -y

# Install LinuxGSM and the chosen game
cd /home/ubuntu
curl -Lo ./linuxgsm https://linuxgsm.sh
chmod +x ./linuxgsm 
su - ubuntu /home/ubuntu/linuxgsm necserver
su - ubuntu /home/ubuntu/necserver auto-install

# # Copy config file
cat <<EOF > /home/ubuntu/serverfiles/cfg/server.cfg
    SERVER = {
            port = 14159,                           // [0 - 65535] Server default port
            slots = 10,                             // [1 - 250] Server default slots
            password = ${GAMEPASSWORD},                          // Leave blank for no password
            pauseWhenEmpty = true,
            giveClientsPower = true,        // If true, clients will have much more power over what hits them, their position etc
            logging = true,                         // If true, will create log files for each server start
            language = en,
            zipSaves = false,                       // If true, will create new saves in a zipfile
            MOTD = "Welcome!",                      // Message of the day
      }
EOF

cat <<EOF > /etc/systemd/system/necesse.service
[Unit]
Description=Necesse Dedicated Server
After=network.target

[Service]
PrivateTmp=true
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu
ExecStart=/home/ubuntu/necserver start
ExecStop=/home/ubuntu/necserver stop
Restart=no

[Install]
WantedBy=multi-user.target

EOF
systemctl daemon-reload
systemctl enable necesse.service
systemctl start necess.service