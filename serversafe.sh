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
    
# Google Authenticator installieren
    sudo apt install libpam-google-authenticator -y

# Google Authenticator starten
    google-authenticator
    clear
echo "Suchen Sie \"@include common-password\" und schreiben Sie da drunter \"auth required pam_google_authenticator.so\". (Bitte lesen Sie die Anleitung auf github) Weitere mit Enter..."
    read
    sudo nano /etc/pam.d/sshd
    clear
echo "Suchen Sie nun \"ChallangeResponseAuthentication\" und setzen Sie den Wert auf \"yes\". (Bitte lesen Sie die Anleitung auf github) Weitere mit Enter..."
    read
    sudo nano /etc/ssh/sshd_config
    clear
echo "Ein Reboot wird durchgeführt"
        sleep 2
    sudo reboot now
fi
