#!/bin/bash
clear
read -p"Server jetzt absichern? (j/n) " response

if [ "$response" == "j" ]; then
# Server Update und Upgrade
    sudo apt update && sudo apt upgrade -y
# Apticron installieren
    sudo apt install apticron -y
    sudo nano /etc/apticron/apticron.conf
clear
# SSH Root Login verbieten
echo "SSH Root Login wird geschlossen. Welcher Benutzer soll neu angelegt werden?"
  read newuser
  sudo adduser $newuser
  sudo usermod -aG sudo $newuser
echo "Suchen Sie nun PermitRootLogin und ändern Sie dieses auf PermitRootLogin no" response
  sudo nano /etc/ssh/sshd_config

fi
