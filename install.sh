#!/usr/bin/env bash
clear
termux-wake-lock
echo "This is just an installer! \nRefer to the documentation of the Node Red for any doubt"
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

PM2=
NODERED=
MOSQUITO=
HASS=true

echo "Update repo"
pkg update

echo "Ask for storage permissionss"
termux-setup-storage
sleep 5

echo "Configure SSH"
echo y | pkg install openssh
echo -e "android\nandroid" | passwd
sshd

echo "Install dependencies"
echo y | pkg install openssl
echo y | pkg install clang
echo y | pkg install python
echo y | pkg install python
echo y | pkg install coreutils
echo y | pkg install nano
echo y | pkg install nodejs
echo y | pkg install openssh
echo y | pkg install termux-api
echo y | pkg install make
echo y | pkg install curl
echo y | pkg install libjpeg-turbo
echo y | pkg install binutils
echo y | pkg install ndk-sysroot
echo y | pkg install build-essential

if [ -n "$NODERED" ] || [ -n "$MOSQUITTO" ];then
    PM2=true
fi

if [ -n "$PM2" ];then
    echo "Install pm2"
    npm i -g --unsafe-perm pm2
fi

if [ -n "$MOSQUITTO" ];then
    echo "Install and start mosquitto" 
    echo y | pkg install mosquitto
    pm2 start mosquitto -- -v -c /data/data/com.termux/files/usr/etc/mosquitto/mosquitto.conf
fi

if [ -n "$NODERED" ];then
    echo "Install and  start node-red"
    npm i -g --unsafe-perm node-red
    pm2 start node-red
    cd ~/.node-red/
    npm install node-red-dashboard
    npm install node-red-contrib-termux-api
    pm2 restart node-red
    cd ~
fi

if [ -n "$PM2" ];then
    echo "Save pm2 config"
    pm2 save 
    echo "Add pm2 resurrect to boot file"
    [ ! -d ~/.termux/boot/ ] && mkdir -p ~/.termux/boot/
    echo -e "#!/data/data/com.termux/files/usr/bin/sh \ntermux-wake-lock \n. \$PREFIX/etc/profile \nsshd \npm2 start all" > ~/.termux/boot/start.sh
fi



if [ -n "$HASS" ];then
    #Install homeassistant
    pip install --upgrade pip
    pip install --upgrade wheel

    export CARGO_BUILD_TARGET="aarch64-linux-android"
    #pkg install python-cryptography
    echo y | pkg install rust

    pip install maturin

    pip download orjson==3.8.3
    tar xf orjson-3.8.3.tar.gz
    cd orjson-3.8.3/
    sed -i 's/lto = "thin"/#lto = "thin"/g' Cargo.toml
    maturin build --release --strip
    cd ~
    rm orjson-3.8.3.tar.gz
    tar -czf orjson-3.8.3.tar.gz orjson-3.8.3

    pip download cryptography==38.0.4
    tar xf cryptography-38.0.4.tar.gz
    cd cryptography-38.0.4/src/rust/
    sed -i 's/lto = "thin"/#lto = "thin"/g' Cargo.toml
    maturin build --release --strip
    cd ~
    rm cryptography-38.0.4.tar.gz
    tar -czf cryptography-38.0.4.tar.gz cryptography-38.0.4


    python -m venv homeassistant
    source homeassistant/bin/activate

    printf "aiohttp>=3.8.3\ncryptography>=38.0.4\norjson>=3.8.3" > req.txt
    pip install --upgrade pip
    pip install --upgrade wheel
    pip install aiohttp
    pip install orjson-3.8.3.tar.gz
    pip install cryptography-38.0.4.tar.gz
    pip install -r req.txt homeassistant
fi











IP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"




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
[ -n "$NODERED" ] && echo -e "NODE-RED: port 1880 (browser) (http://${IP}:1880)\n"
[ -n "$NODERED" ] && echo -e "NODE-RED DASHBOARD: port 1880 (browser) (http://${IP}:1880/ui)\n"
[ -n "$MOSQUITO" ] && echo -e "MOSQUITO: port 1883 (Mqtt Client)\n"
echo -e "You should change yor password now using 'passwd' (once connted via ssh)"
