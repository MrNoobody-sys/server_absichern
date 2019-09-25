#!/bin/bash
clear
read -p "Server jetzt absichern? (j/n) " response

if [ "$response" == "j" ]; then
# Server Update und Upgrade
    sudo apt update && sudo apt upgrade -y
# Apticron installieren
    sudo apt install apticron -y
echo "Ändern Sie ihre E-Mail Adresse für Apticron \"EMAIL=deine@mailadresse.de\". Weitere mit Enter..."
    read
    sudo nano /etc/apticron/apticron.conf
clear
echo "Suchen Sie nun PermitRootLogin yes und ändern Sie dieses auf PermitRootLogin no. Weitere mit Enter..."
    read
    sudo nano /etc/ssh/sshd_config
    sudo reboot now

fi
