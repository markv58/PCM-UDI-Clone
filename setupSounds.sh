!#/usr/bin/env bash

echo "Setting up sounds"

if [ != -d "/home/pi/Sounds" ]; then
  mkdir /home/pi/Sounds
  cp -a /home/pi/Sounds/. /home/pi/PCM-UDI-Clone/Sounds/
else
  echo "Sounds are already installed"
exit

fi
