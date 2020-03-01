#!/bin/bash

echo "Setting up sounds"

if [ ! -d "/home/pi/Sounds" ]; then
  mkdir /home/pi/Sounds
  cp -a /home/pi/PCM-UDI-Clone/Sounds/. /home/pi/Sounds/
else
  echo "Sounds are already installed"
exit

fi
