#!/bin/bash

echo "Setting up sounds"

if [ ! -d "/home/pi/Sounds" ]; then
  sudo mkdir /home/pi/Sounds
fi

if [ ! -f /home/pi/Sounds/sound1.wav ]; then
  sudo cp -a /home/pi/PCM-UDI-Clone/Sounds/. /home/pi/Sounds/
fi

exit
