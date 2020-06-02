#!/bin/bash

if [ ! -d /home/pi/cgi-bin ]; then
sudo mkdir /home/pi/cgi-bin
fi

if [ ! -d /home/pi/.config/autostart ]; then
sudo mkdir /home/pi/.config/autostart
fi

sudo cp /home/pi/PCM-UDI-Clone/CgiHttpSRV.desktop /home/pi/.config/autostart

git config core.filemode false

sudo cp ~/PCM-UDI-Clone/CgiHttpSRV.py ~/cgi-bin/
sudo cp ~/PCM-UDI-Clone/2tone ~/cgi-bin/

if [ ! -f /home/pi/cgi-bin/CloneCtrl1a ]; then
sudo cp ~/PCM-UDI-Clone/CloneCtrl1a ~/cgi-bin/
fi

if [ ! -f /home/pi/cgi-bin/CloneCtrl2b ]; then
sudo cp ~/PCM-UDI-Clone/CloneCtrl2b ~/cgi-bin
fi

if [ ! -e /home/pi/cgi-bin/CloneCtrl3 ]; then
echo "CloneCtrl3 does not exist, installing in ~/cgi-bin"
sudo cp ~/PCM-UDI-Clone/CloneCtrl3 ~/cgi-bin
elif [ -e /home/pi/cgi-bin/CloneCtrl3 ]; then
echo "Your exitsting CloneCtrl3 file has been saved as CloneCtrl3.bak"
echo "If you have already input your custom settings you can copy them to the new CloneCtrl3 file" 
sudo mv ~/cgi-bin/CloneCtrl3 ~/cgi-bin/CloneCtrl3.bak
sudo cp ~/PCM-UDI-Clone/CloneCtrl3 ~/cgi-bin
fi

if [ ! -e /home/pi/cgi-bin/CloneCtrl3gen ]; then
echo "CloneCtrl3 does not exist, installing in ~/cgi-bin"
sudo cp ~/PCM-UDI-Clone/CloneCtrl3gen ~/cgi-bin
elif [ -e /home/pi/cgi-bin/CloneCtrl3gen ]; then
echo "Your exitsting CloneCtrl3gen file has been saved as CloneCtrl3gen.bak"
echo "If you have already input your custom settings you can copy them to the new CloneCtrl3 file" 
sudo mv ~/cgi-bin/CloneCtrl3gen ~/cgi-bin/CloneCtrl3gen.bak
sudo cp ~/PCM-UDI-Clone/CloneCtrl3gen ~/cgi-bin
fi

sudo chmod +x -R /home/pi/cgi-bin

sudo mv /home/pi/cgi-bin/2tone /usr/bin/
sudo mv /home/pi/cgi-bin/CgiHttpSRV.py /home/pi/
sleep 2s

sudo chmod +x PFsetup.sh
sudo chmod +x setupMM.sh
sudo chmod +x setupSounds.sh
sh PFsetup.sh normal # set up PictureFrame folders
sh setupMM.sh normal # set up MagicMirror2 folders
sh setupSounds.sh

if [ ! -e ~/Pictures/blank.png ]; then
  sudo cp ~/PCM-UDI-Clone/blank.png  ~/Pictures/
fi

sudo chmod 644 PFsetup.sh
sudo chmod 644 setupMM.sh
sudo chmod 644 setupSounds.sh
echo "Rebooting in 20 seconds"
sudo chmod 644 install.sh
sleep 20s
sudo reboot

