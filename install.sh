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

if [ ! -f /home/pi/cgi-bin/CloneCtrl3 ]; then
sudo cp ~/PCM-UDI-Clone/CloneCtrl3 ~/cgi-bin
fi

sudo chmod +x -R /home/pi/cgi-bin

sudo mv /home/pi/cgi-bin/2tone /usr/bin/
sudo mv /home/pi/cgi-bin/CgiHttpSRV.py /home/pi/
sleep 2s

chmod +x PFsetup.sh
chmod +x setupMM.sh
chmod +x setupSounds.sh
sh PFsetup.sh normal # set up PictureFrame folders
sh setupMM.sh normal # set up MagicMirror2 folders
sh setupSounds.sh
chmod 644 PFsetup.sh
chmod 644 setupMM.sh
chmod 644 setupSounds.sh
echo "Reboot in 20 seconds"
chmod 644 install.sh
sleep 20s
sudo reboot

