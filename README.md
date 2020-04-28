# Server absichern für Ubuntu 18.04

## Bitte als erstes einen neuen Benutzer anlegen

    sudo adduser BENUTZER
    sudo usermod -aG sudo BENUTZER
    su BENUTZER

## Install with Google Authenticator
1. git clone https://github.com/MrNoobody-sys/server_absichern.git
2. cd server_absichern
4. bash ./safeguarding.sh

## Install without Google Authenticator
1. git clone https://github.com/MrNoobody-sys/server_absichern.git
2. cd server_absichern
4. bash ./without_google_auth.sh
