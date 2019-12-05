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
clear
# s-nail installieren, bei jedem SSH Login wird eine E-Mail versendet
echo "Installation von s-nail um E-Mails bei SSH Logins zu versenden. Weiter mit Enter..."
    read
    sudo apt install s-nail -y
    sudo printf "#!\/bin\/bash echo \"Login auf $(hostname) am $(date +%Y-%m-%d) um $(date +%H:%M)\" echo \"Benutzer: $USER\"\ echo pinky>/opt/shell-login.sh
echo \"Damit die Mails beim Login versendet werden, muss in der Datei /etc/profile folgende Zeile angefügt werden:
/opt/shell-login.sh | mailx -s \"SSH Login auf IHR-HOSTNAME\" ihre-emailadresse@example.com Weiter mit Enter..."
    read
    sudo nano /etc/profile
    sudo chmod 755 /opt/shell-login.sh
    clear
# SSH Port ändern
echo "SSH Port in 60200 ändern. Weiter mit Enter..."
    read
    sudo nano /etc/ssh/sshd_config
    sudo systemctl restart sshd.service
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
