# Smartdroid
This script will install Home Assistant, Node Red And Mosquito on Android device using Termux.

The aim of such software is to reutilize old Android device that are no more useful as phones, but that can live a second life as a smart home hub.

Right now the installation as been tested on 64bit device only, it should work also on 32bit (with little changes) system as long as all dependency are avaible (Not tested).
The target devices must run Android version above 6, otherwise it's not possibile to install termux, which is required to install everything.

Due to architectural issue with some dependency, not all module could be installable at this time, see "Known issue" for more info.

## Getting started
### Before start
Be sure that your device's screen stays on during the whole process and activate "unknow sources" option.

* Enable the "developer mode" ([How to enable "developer mode"](https://www.google.com/search?q=How+to+enable+developer+mode+android))
* Go to "Developer options" and flag the "Stay awake" option
* Enable "Unknow sources" installation option ([How to enable "unknow sources"](https://www.google.com/search?q=How+to+enable+unknow+sources+android))
* Plug the device into a charger

### Install

* Download and install [Fdroid](https://f-droid.org/)
* Search and install "Termux" on Fdroid
* Open Termux and paste the following:
 ```bash
 pkg update && curl https://raw.githubusercontent.com/mattiabonzi/droid-assistant/main/install.sh | bash
 ```
* Ignore the `node-pre-gyp` error
* Take a coffee (the process can take up to 1 hour)
* Done! You can now connect to (replace 192.168.x.x with your actual IP):
	* Server console using `ssh admin@192.168.x.x -p 8022` with a terminal
	* NodeRed dashboard on `http://192.168.x.x:1880`, yuo could acces it from Hass dashboard too.


## Known issue

##### cryptography >= 3.4
Need's Rust to run, not avaible at this time for Linux Android aarch64.
It's not possibile (in most cases) to build rust directly on Android device due to amount of disk space and ram required, that in most case exceeds what are avaible on an old Android device [See Rust doc. for more info](https://rustc-dev-guide.rust-lang.org/building/prerequisites.html#hardware).
A possible solution to this problem could be to realese a pre-compiled version of Rust for Linux Android aarch64.


## Old smartphone
If you are interested in running the program on devices that use an android version lower than 6, you could try to download and install older version of termux from [Archive.org](https://archive.org/details/termux-repositories-legacy)
	
