#!/bin/bash
clear
read -p"Server jetzt absichern? (j/n) " response

if [ "$response" == "j" ]; then
# Server Update und Upgrade
    sudo apt update && sudo apt upgrade -y
# Apticron installieren
    sudo apt install apticron -y
echo "Ändern Sie ihre E-Mail Adresse für Apticron \"EMAIL=deine@mailadresse.de\". Weitere mit Enter..." response
    sudo nano /etc/apticron/apticron.conf
clear
# SSH Root Login verbieten
echo "SSH Root Login wird geschlossen. Welcher Benutzer soll neu angelegt werden?"
  read newuser
  sudo adduser $newuser
  sudo usermod -aG sudo $newuser
echo "Suchen Sie nun PermitRootLogin yes und ändern Sie dieses auf PermitRootLogin no. Weitere mit Enter..." response
  sudo nano /etc/ssh/sshd_config
  sudo reboot now

fi
