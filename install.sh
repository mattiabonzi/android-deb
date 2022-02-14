#!/usr/bin/env bash
echo "Init"
clear
echo "This is just an installer! \nRefer to the documentation of the single sofwtare for any doubt"
echo "Script write with <3 by:\n"
echo "  ______           __  \n /_  __/_  _______/ /_ \n  / / / / / / ___/ __ \\n / / / /_/ / /__/ / / /\n/_/  \__,_/\___/_/ /_/ \n\n"
echo "Be sure that you are connected to internet, and taht you're running Android > 6 (api 24)\nFor more info please visit: "
echo "Update repo"
pgk update
pkg upgrade
echo "Install dependencies"
pkg install -y python-dev libffi-dev openssl-dev coreutils clang python coreutils nano mosquitto nodejs openssh termux-api make curl
pip install pynacl==1.3.0
pip install netdisco
echo "Install pm2 and node-red"
npm i -g --unsafe-perm pm2 node-red
echo "Install home-assistant"
python -m venv homeassistant
source homeassistant/bin/activate
pip install homeassistant
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
echo "panel_iframe:\nconfigurator\n:\ntitle: Configurator\nicon: mdi:wrench\nurl: http://x.x.x.x:3218\nnode_red:\ntitle: Node-RED\nicon: mdi:cogs\nurl: http://x.x.x.x:1880" | /data/data/com.termux/files/home/.homeassistant/configuration.yaml
echo "Done"
