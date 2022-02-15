#!/usr/bin/env bash
echo "Init"
clear
echo "This is just an installer! \nRefer to the documentation of the single sofwtare for any doubt"
echo "Script write with <3 by:"
echo "   ______           __  "
echo "  /_  __/_  _______/ /_ "
echo "   / / / / / / ___/ __ \ "
echo "  / / / /_/ / /__  / / / "
echo " /_/  \__,_/\___/_/ /_/ "
echo "Be sure that you are connected to internet, and taht you're running Android > 6 (api 24)\nFor more info please visit: "
echo "Update repo"
pkg update -y
echo "Ask for storage permissionss"
termux-setup-storage
echo "Install dependencies"
pkg install -y openssh
echo -e "android\nandroid" | passwd
sshd
pkg install -y libffi openssl coreutils clang python python nano mosquitto nodejs openssh termux-api make curl libjpeg-turbo binutils ndk-sysroot build-essential
pip install netdisco
echo "Install pm2 and node-red"
npm i -g --unsafe-perm pm2 node-red
echo "Install home-assistant"
python -m venv homeassistant
source homeassistant/bin/activate
pip install --upgrade pip
pip install --upgrade wheel
pip install aiohttp==3.7.4.
pip install post0astral==2.2
pip install async-timeout==3.0.1
pip install attrs==21.2.0
pip install awesomeversion==21.8.1
pip install backports.zoneinfo
pip install bcrypt==3.1.7
pip install certifi>=2021.5.30
pip install ciso8601==2.2.0
pip install cryptography==3.3.2
pip install typing-extensions\<5.0,\>=3.10.0.2
pip install httpx==0.19.0
pip install jinja2==3.0.1
pip install PyJWT==2.1.0
pip install python-slugify==4.0.1
pip install pyyaml==5.4.1
pip install requests==2.26.0
pip install voluptuous==0.12.2
pip install voluptuous-serialize==2.4.0
pip install yarl==1.6.3
pip install pynacl==1.4.0
LDFLAGS="-L/system/lib64/" CFLAGS="-I/data/data/com.termux/files/usr/include/" pip install pillow==8.2.0
echo "cryptography==3.3.2" > constr.txt
pip install -c constr.txt  hass-nabucasa==0.50.0
pip install --no-deps homeassistant==2021.10.1
echo "Start homeassistant for first time to let it configure themself, then stop it (20m)"
timeout 20m hass
pip install -I pytz
echo "Install home-assistant configurator"
cd /data/data/com.termux/files/home/.homeassistant
curl -LO https://raw.githubusercontent.com/danielperna84/hass-configurator/master/configurator.py
chmod 755 configurator.py
echo "Start home-assistant"
pm2 start hass --interpreter=python -- --config /data/data/com.termux/files/home/.homeassistant
echo "Start mosquitto" 
pm2 start mosquitto -- -v -c /data/data/com.termux/files/usr/etc/mosquitto/mosquitto.conf
echo "Start node-red"
pm2 start node-red
echo "Start configurator"
pm2 start /data/data/com.termux/files/home/.homeassistant/configurator.py
echo "Add Node-RED and Configurator to HASS sidebar"
echo -e "\npanel_iframe:\nconfigurator\n:\ntitle: Configurator\nicon: mdi:wrench\nurl: http://127.0.0.1:3218\nnode_red:\ntitle: Node-RED\nicon: mdi:cogs\nurl: http://127.0.0.1:1880" >> /data/data/com.termux/files/home/.homeassistant/configuration.yaml
echo "Save pm2 config"
pm2 save 
echo "Add pm2 resurrect to bashrc file"
#TODO

echo -e "\n\n\a\a\aDone\n\nScript write with <3 by:";
echo -e "   ______           __  "
echo -e "  /_  __/_  _______/ /_ "
echo -e "   / / / / / / ___/ __ \ "
echo -e "  / / / /_/ / /__  / / / "
echo -e " /_/  \__,_/\___/_/ /_/ \n"
echo -e "Use Username: 'admin' and Password: 'android' to connect to the device via ssh on local network (port 8022)\n
To check your ip (may vary) go to (on your phone): 'Setting' => 'Device information' => 'Device status' => 'Ip adress'\n
The ssh command should look like this: 'ssh admin@192.168.x.x -p 8022'\n
You should change yor password now using 'passwd' (once connted via ssh)"
