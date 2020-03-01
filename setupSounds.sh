#!/bin/bash

echo "Setting up sounds"

if [ ! -d "/home/pi/Sounds" ]; then
  mkdir /home/pi/Sounds
fi

if [ ! -f /home/pi/Sounds/sound1.wav ]; then
  cp -r /home/pi/PCM-UDI-Clone/Sounds/. /home/pi/Sounds/
fi

exit
