#!/bin/bash

echo "MagicMirror setup"
case "$1" in
  normal)
    if [ ! -d "/home/pi/MagicMirror" ]; then
      echo "MagicMirror2 is not installed"
      exit
    else
      echo "MagicMirror2 is installed"
    fi

    if [ -e "/home/pi/MagicMirror/config/config.js" ]; then
      echo "The MagicMirror2 files are already installed"
      exit
    else
      cp ~/PCM-UDI-Clone/config.js ~/MagicMirror/config/
      cp ~/PCM-UDI-Clone/custom.css ~/MagicMirror/css/
      cp ~/PCM-UDI-Clone/main.css ~/MagicMirror/css/
      mkdir ~/MagicMirror/modules/Pictures
      cp /home/pi/PCM-UDI-Clone/sample.jpg /home/pi/MagicMirror/modules/Pictures/
      echo "The MagicMirror2 files have been installed"
    fi
    ;;
  force)
    cp ~/PCM-UDI-Clone/config.js ~/MagicMirror/config/
    cp ~/PCM-UDI-Clone/custom.css ~/MagicMirror/css/
    cp ~/PCM-UDI-Clone/main.css ~/MagicMirror/css/
    mkdir ~/MagicMirror/modules/Pictures
    cp /home/pi/PCM-UDI-Clone/sample.jpg /home/pi/MagicMirror/modules/Pictures/
    echo "The MagicMirror2 files have been installed"
    ;;

*)
exit 1
;;

esac
