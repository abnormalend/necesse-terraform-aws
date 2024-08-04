#!/bin/bash

echo "This is my userdata for ${GAMENAME}"

# Install steamcmd
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
apt install steamcmd -y


# Copy config file
cat <<EOF > /home/ubuntu/server.cfg
    SERVER = {
            port = 14159,                           // [0 - 65535] Server default port
            slots = 10,                             // [1 - 250] Server default slots
            password = password,                          // Leave blank for no password
            pauseWhenEmpty = true,
            giveClientsPower = true,        // If true, clients will have much more power over what hits them, their position etc
            logging = true,                         // If true, will create log files for each server start
            language = en,
            zipSaves = false,                       // If true, will create new saves in a zipfile
            MOTD = "Welcome!",                      // Message of the day
      }
EOF

# Install LinuxGSM and the chosen game
curl -Lo /usr/local/bin/linuxgsm https://linuxgsm.sh && chmod +x /usr/local/bin/linuxgsm && bash /usr/local/bin/linuxgsm necserver
necserver install