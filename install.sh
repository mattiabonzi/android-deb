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
echo "Use only thermux veriosn downloaded by f-droid (do not use Play-store)"
echo "Install also Termux api app from f-droid to use the sensor of the phone isnide node-red"
echo "Install also Termux boot app from f-droid to launch evetything on startup"
echo "Update repo"
pkg update -y
echo "Ask for storage permissionss"
termux-setup-storage
sleep 5
echo "Install dependencies"
pkg install -y openssh
echo -e "android\nandroid" | passwd
sshd
echo y | pkg install -y openssl
echo y | pkg install -y clang
echo y | pkg install -y python
echo y | pkg install -y python
echo y | pkg install -y coreutils
echo y | pkg install -y nano
echo y | pkg install -y mosquitto
echo y | pkg install -y nodejs
echo y | pkg install -y openssh
echo y | pkg install -y termux-api
echo y | pkg install -y make
echo y | pkg install -y curl
echo y | pkg install -y libjpeg-turbo
echo y | pkg install -y binutils
echo y | pkg install -y ndk-sysroot
echo y | pkg install -y build-essential
echo "Install pm2 and node-red"
npm i -g --unsafe-perm node-red
npm i -g --unsafe-perm pm2 
echo "Start mosquitto" 
pm2 start mosquitto -- -v -c /data/data/com.termux/files/usr/etc/mosquitto/mosquitto.conf
echo "Start node-red"
pm2 start node-red
echo "Save pm2 config"
pm2 save 
echo "Add pm2 resurrect to boot file"
echo -e "#!/data/data/com.termux/files/usr/bin/sh \ntermux-wake-lock \n. \$PREFIX/etc/profile \nsshd \npm2 start" > ~/.termux/boot/start.sh

IP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
cd ~/.node-red/
npm install node-red-dashboard
npm install node-red-contrib-termux-api



echo -e "\n\n\a\a\aDone\n\nScript write with <3 by:";
echo -e "   ______           __  "
echo -e "  /_  __/_  _______/ /_ "
echo -e "   / / / / / / ___/ __ \ "
echo -e "  / / / /_/ / /__  / / / "
echo -e " /_/  \__,_/\___/_/ /_/ \n"
echo -e "Use Username: 'admin' and Password: 'android' to connect to all servuies, you should change this ASAP!"
echo -e "Yout IP should be: ${IP}"
echo -e "Online services:\n"
echo -e "SSH: port 8022 (use a ssh client) (ssh admin@${IP} -p 8022)\n"
echo -e "NODE-RED: port 1880 (browser) (http://${IP}:1880)\n"
echo -e "NODE-RED DASHBOARD: port 1880 (browser) (http://${IP}:1880/ui)\n"
echo -e "MOSQUITO: port 1883 (Mqtt Client)\n"
echo -e "You should change yor password now using 'passwd' (once connted via ssh)"
