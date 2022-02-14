#!/usr/bin/env bash
echo "Init"
clear
echo "This is just an installer! \nRefer to the documentation of the single sofwtare for any doubt"
echo "Script write with <3 by:\n\n\n"
echo "  ______           __  \n /_  __/_  _______/ /_ \n  / / / / / / ___/ __ \\n / / / /_/ / /__/ / / /\n/_/  \__,_/\___/_/ /_/ \n\n\n"
echo "Be sure that you are connected to internet, and taht you're running Android > 6 (api 24)\nFor more info please visit: "
echo "Update repo"
pgk update
echo "Install dependencies"
pkg install -y openssh 
echo "android" | passwd
sshd
pkg install -y  ibffi-dev openssl-dev coreutils clang python3 python3-dev nano mosquitto nodejs openssh termux-api make curl
pip3 install --upgrade pip
pip3 install pynacl==1.3.0
pip3 install netdisco
echo "Install pm2 and node-red"
npm i -g --unsafe-perm pm2 node-red
echo "Install home-assistant"
python3.9 -m venv homeassistant
source homeassistant/bin/activate
pip3 install homeassistant==2021.9.7
echo "Install home-assistant configurator"
cd /data/data/com.termux/files/home/.homeassistant
curl -LO https://raw.githubusercontent.com/danielperna84/hass-configurator/master/configurator.py
chmod 755 configurator.py
echo "Start mosquitto" 
pm2 start mosquitto -- -v -c /data/data/com.termux/files/usr/etc/mosquitto/mosquitto.conf
echo "Start node-red"
pm2 start node-red
echo "Start home-assistant"
pm2 start hass --interpreter=python -- --config /data/data/com.termux/files/home/.homeassistant
echo "Start configurator"
pm2 start /data/data/com.termux/files/home/.homeassistant/configurator.py
echo "Add Node-RED and Configurator to HASS sidebar"
echo "\npanel_iframe:\nconfigurator\n:\ntitle: Configurator\nicon: mdi:wrench\nurl: http://x.x.x.x:3218\nnode_red:\ntitle: Node-RED\nicon: mdi:cogs\nurl: http://x.x.x.x:1880" >> /data/data/com.termux/files/home/.homeassistant/configuration.yaml
echo "Done"
echo "Use Username: 'admin' and Password: 'android' to connect to the device via ssh on local network (port 8022)"
echo "To check your ip (may vary) go to (on your phone): 'Setting' => 'Device information' => 'Device status' => 'Ip adress'"
echo "The ssh command should look like this: 'ssh admin@192.168.x.x -p 8022'"
