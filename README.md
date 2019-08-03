# PiCamClone
For the PiCamMonitor v2.0.0
### This will only work with the official Raspberry Pi 7" touch screen.

With this you will be able to have clones that a PiCamMonitor controller can operate. No extra node slots or additional programs will be needed to add a clone. The installation is nearly identical to the PiCamMonitor.

If converting an exitsting PiCamMonitor v1.x to a clone or creating a new clone follow these instructions. Converting will require re-imaging the sd card.

# Installation

### HARDWARE:

* Raspberry Pi 3 B+
* 5.2 vdc 3 amp power supply, I've found the 2.5 amp to be too weak to power the Pi and screen.
* 16 - 32 GB micro sd card
* Official Raspberry Pi 7" touch screen 
* SmartiPi Touch Case* - https://smarticase.com available on Amazon.com

### OPTIONAL:

* Piezo buzzer - https://www.amazon.com/Cylewet-Mainboard-Computer-Internal-Speaker/dp/B01MR1A4NV/ref=sr_1_1_sspa?s=electronics&ie=UTF8&qid=1550533551&sr=1-1-spons&keywords=piezo+buzzer&psc=1 I realize there are 10, but they are cheap and once you get one of these running, you may just want a few more. This connects to GPIO pins 9 thru 15 with the black wire on pin 9. https://pinout.xyz
* Heatsinks - 

Assemble the Smarti Pi case, screen and raspberry pi, instructions and video here - https://smarticase.com/products/smartipi-touch .

Download the full version of Raspbian Stretch with Desktop and recommended software found here - https://www.raspberrypi.org/downloads/raspbian/ .
Extract the files.

Using Etcher (Mac) https://www.balena.io/etcher/ , or
Win32DiskManager (PC) https://sourceforge.net/projects/win32diskimager/ , image the micro sd card.
After imaging, insert the sd card into the pi, replace the cover, plug in a usb mouse and keyboard and power up. The mouse and keyboard are only needed for the initial set-up.

You will be presented with the Welcome screen.

Follow the promts to set up your device, connect to your wifi and then update the software. (This will take a while) (If you encounter an error before the updates start just click Back and start again, it happens.)

While you wait for the Pi to update, you may want VNC viewer installed on your main computer. https://www.realvnc.com/en/connect/download/viewer/ You might find it useful to install the VNC viewer on an iPad or other tablet.

When the updates have been installed, click OK and then reboot. Click the menu in the top left corner and select Preferences/Raspberry Pi Configuration.

On the first page select Wait for Network. Select Interfaces tab and check SSH and VNC enable. Select Performance tab and change the GPU memory to 256. Click OK then YES to reboot.

Set a static ip address. Depending on your system there are various way to achieve this. On the Pi itself, open the terminal window and enter

    sudo nano /etc/dhcpcd.conf
    
hit enter and scroll to the bottom.

Enter (editing the ip numbers to match your network configuration, eth0=wired, wlan0=wireless):

    interface eth0

    static ip_address=192.168.0.10/24
    static routers=192.168.0.1
    static domain_name_servers=8.8.8.8 8.8.4.4
    
    interface wlan0
    
    static ip_address=192.168.0.200/24
    static routers=192.168.0.1
    static domain_name_servers=8.8.8.8 8.8.4.4

Note your ip address. Exit the editor, press ctrl+x, press the letter 'Y' then enter.

Enter:

    sudo reboot
    
and hit enter for the changes to take affect. 

You can now move to VNC, ssh or continue with the mouse and keyboard.

I've found it easier to cut and paste the commands using ssh and working with the Pi desktop using the VNC option.

### Set resolution

This will make MagicMirror use the screen efficiently and gives you a better desktop resolution if you want to work
on some of the Pi settings like the screen saver and desktop settings.

    cd ~
    cd /boot
    sudo nano config.txt

Scroll down serveral lines and find the lines below and edit so that they are the same.

    # uncomment to force a console size. By default it will be display's size minus
    # overscan.
    framebuffer_width=1160
    framebuffer_height=700

Hit ctrl+x then 'Y' and enter to save the changes.

Reboot the Pi:

    sudo reboot

Setup your desktop preferences if you choose.

### Screensaver

Next we need to stop the screen from blanking after 10 minutes. In the terminal enter

    sudo apt-get install xscreensaver 
    
then hit enter. 

Once all the files are installed and you are back to the prompt it's time to run the screen saver and set it to disable.
Go to the desktop select the raspberry/Preferences/Screensaver and set the mode to Disable Screen Saver and close the window. You may be asked to start the service. Now the screen should stay on like we want.

### Samba

Set up Samba so you can transfer your pictures, in the terminal enter

    sudo apt-get install samba samba-common-bin
    
and hit enter. Back at the prompt enter

    sudo nano /etc/samba/smb.conf
    
and hit enter. Scroll to the very bottom and enter:

    [global]

    workgroup = workgroup 
    server string = %h  
    wins support = no
    dns proxy = no
    security = user
    map to guest = Bad User
    encrypt passwords = yes
    panic action = /usr/share/samba/panic-action %d
  

    [Home]

    comment = Home Directory
    path = /home/pi
    browseable = yes
    writeable = yes
    guest ok = yes
    read only = no
    force user = root
  
Again, press ctrl+x hit 'Y' then enter to save the file. Enter:

    sudo samba restart
    
then enter for the changes to take effect. When you connect from your computer, log in as guest and you can copy your pictures to the appropriate folder under the /home/pi/Pictures folder or to the /home/pi/MagicMirror/modules/Pictures folder that MagicMirror will use. The initial install will copy sample.jpg to every picture folder to avoid errors from choosing an empty folder. Delete that file when you populate the folder.
  
Three more quick installs and we are ready for MagicMirror2 and Polyglot. Enter the following, answer y if asked to let them install.

    sudo apt-get install screen
    sudo apt-get install feh
    sudo apt-get install unclutter

## MagicMirror installation:

Execute the following one at a time:

    cd ~
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt install -y nodejs
    git clone https://github.com/MichMich/MagicMirror
    cd MagicMirror
    npm install

⚠️ Important!

The installation step for npm install will take a few minutes, often with little or no terminal response! 
Do not interrupt or you risk getting a jam.

    cd modules
    git clone https://github.com/darickc/MMM-BackgroundSlideshow.git
    cd MMM-BackgroundSlideshow
    npm install

Ignore warnings.

You will need to register for and get an API key for the weather module: (skip if you have already registered and have a key)

    https://openweathermap.org

This will download the city list where you can find your location id:

    http://bulk.openweathermap.org/sample/city.list.json.gz

Un-zip the file and find your location ID.

This information will be needed after the Clone program is installed.

When you install PiCamMonitor configuration files will also be installed for MagicMirror. This will get you up and running quickly and you can modify the MagicMirror to suit your needs if you choose to. Your location ID and API key will need to be inserted into the config.js file in two locations after you install the PiCamClone program.

## Install the Clone program

This will install the files and reboot the Pi.

     cd ~
     git clone https://github.com/markv58/PCM-UDI-Clone.git
     
     cd PCM-UDI-Clone
     chmod +x install.sh
     
     ./install.sh
     
If there is an update you will need to do a git pull to install the new files. When that needs to be done there will be a notice in the Polyglot UI and you will find the update instructions right here.     

### Insert your weather module information in the configuration file:

    cd ~/MagicMirror/config
    nano config.js

### Camera Feeds and Paths setup and testing:

If you have already established your feeds skip this.

With high resolution cameras you will use the sub stream, the higher resolutions will not play properly. Log into your camera through a web brower and make sure your sub stream is enabled, set to 640x480, frame rate to 15 and key frame to 30. This will make your streams load faster.

A lower resolution camera like the Foscam C1, which is still 720p can be streamed from the main feed.

A typical path to the sub feed of a high quality camera. (Amcrest and others in the range)\(PLEASE NOTE the backslash between the 1 and the &, this is a requirement if there is an ampersand in your path)

    rtsp://user:password@192.192.192.195:544/cam/realmonitor?chanel=1\&subtype=1 


A typical path to the main stream on lower end camera such as a Foscam C1.

    rtsp://user:password@192.192.192.192:544/videoMain 


You can search the web for the settings to reach your particular camera.


#### Test your camera feed paths on the Pi using this command line edited with your information:

    sh -c 'omxplayer --win "0 0 800 480" rtsp://USERNAME:PWORD@172.16.2.110:554/cam/realmonitor?channel=1\&subtype=1; exec bash'

This will run the sub stream on an Amcrest and most other high resolution cameras. If you are successful, save your feed path for use in the custom configuration parameters. Use ctrl+c to stop the player.

#### Once you have established you camera feeds:

On each clone:

    cd ~/cgi-bin
    sudo nano CloneCtrl1a
    
Edit the following lines with your information:

    # ------------- Insert camera feed information here --------------------------------------
    cam1='rtsp://user:password@xxx.xxx.xxx.xxx:554/cam/realmonitor?channel=1\&subtype=1'
    cam2='rtsp://user:password@xxx.xxx.xxx.xxx:554/cam/realmonitor?channel=1\&subtype=1'
    cam3='rtsp://user:password@xxx.xxx.xxx.xxx:554/cam/realmonitor?channel=1\&subtype=1'
    cam4='rtsp://user:password@xxx.xxx.xxx.xxx:8327/videoMain'

    PFtime=60   # ------- edit to change the rotation time for PictureFrame ------------------

Edit the PFtime above.

Below is the camera order for the Cams x3 feed order, arrange any way you like by changing the cam#.

    cams3x) # --------- Insert the camera variables for the screen order here ---------------
      screen -dmS stream2 sh -c 'omxplayer --win "0 90 500 390" '$cam3' -b --live; exec bash'
      screen -dmS stream3 sh -c 'omxplayer --win "500 60 800 240" '$cam1' --live; exec bash'
      screen -dmS stream4 sh -c 'omxplayer --win "500 240 800 420" '$cam2' --live; exec bash'
      ;;

If this is a clone of a stand alone PCM, this order should mirror that controller.

Once the editing is complete, hit Ctrl+X then Y and hit enter to save the file.


That's it. Input the clone name and ip address into the Custom Configuration Parameters of a PiCamMonitor controller and restart the PCM nodeserver.

#### If you have any issues or questions, please visit the forums for assisance.

https://forum.universal-devices.com/topic/25817-polyglot-v2-picammonitor

v1.0.0 - CloneCtrl1a. Clone control script for PiCamMonitor v2.0.0

