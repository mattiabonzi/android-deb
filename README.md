# Smartdroid
This script will install Home Assistant, Node Red And Mosquito on Android device using Termux.

Due to an architectural issue with a dependency (cryptography that requires Rust to be compiled on version above 3.4), not all module could be installable at this time.


## Before start
Be sure that your device's screen stays on during the process and activate "unknow sources" option.

* Enable the "developer mode" ([How to enable "developer mode"](https://www.google.com/search?q=How+to+enable+developer+mode+android))
* Go to "Developer options" and flag the "Stay awake" option
* Enable "Unknow sources" installation option ([How to enable "unknow sources"](https://www.google.com/search?q=How+to+enable+unknow+sources+android))
* Plug the device into a charger

## Install

* Download and install [Fdroid](https://f-droid.org/)
* Search and install "Termux" on Fdroid
* Open Termux and paste the following:
 ```bash
 curl -O https://raw.githubusercontent.com/mattiabonzi/droid-assistant/main/install.sh && chmod +x ./install.sh && echo "y" | ./install.sh && rm ./install.sh
 ```
* Ignore the `node-pre-gyp` error
* Take a coffee (the process can take up to 1 hour)
* Done! You can now connect to (replace 192.168.x.x with your actual IP):
	* Hass dashboard on `http://192.168.x.x:8123` with your browser
	* Server console using `ssh admin@192.168.x.x -p 8022` with a terminal
	* NodeRed dashboard on `http://192.168.x.x:1880`, yuo could acces it from Hass dashboard too.

	
