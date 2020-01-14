#!/bin/bash

sudo mkdir /home/pi/cgi-bin
sudo mkdir /home/pi/.config/autostart
sudo cp /home/pi/PCM-UDI-Clone/CgiHttpSRV.desktop /home/pi/.config/autostart
git config core.filemode false
#if [ -f /home/pi/cgi-bin/CloneCtrl1a ]; then
#  cp /home/pi/cgi-bin/CloneCtrl ~/PCM-UDI-Clone/CloneCtrl1a.bak
#  echo "A backup of CloneCtrl1a file has been saved to the PCM-UDI-Clone folder"
#  echo "This may contain valuable information about your cameras"
#  echo "Previous versions remain in the /cgi-bin/ folder but are not used, you may save or delete them"
#fi

sudo cp ~/PCM-UDI-Clone/CgiHttpSRV.py ~/cgi-bin/
sudo cp ~/PCM-UDI-Clone/2tone ~/cgi-bin/

if [ !f /home/pi/cgi-bin/CloneCtrl1a ]; then
sudo cp ~/PCM-UDI-Clone/CloneCtrl1a ~/cgi-bin/
fi

if [ !f /home/pi/cgi-bin/CloneCtrl2a ]; then
sudo cp ~/PCM-UDI-Clone/CloneCtrl2a ~/cgi-bin
fi

sudo chmod +x -R /home/pi/cgi-bin

sudo mv /home/pi/cgi-bin/2tone /usr/bin/
sudo mv /home/pi/cgi-bin/CgiHttpSRV.py /home/pi/
sleep 2s

chmod +x PFsetup.sh
chmod +x setupMM.sh
./PFsetup.sh normal # set up PictureFrame folders
./setupMM.sh normal # set up MagicMirror2 folders
chmod 644 PFsetup.sh
chmod 644 setupMM.sh
echo "Reboot in 20 seconds"
chmod 644 install.sh
sleep 20s
sudo reboot

