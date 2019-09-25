#!/bin/bash
clear
read -p "Google Authenticator installieren? (j/n)" response

if [ "$response" == "j" ]; then

# Server Update
  sudo apt update && sudo apt upgrade -y

# Google Authenticator installieren
  sudo apt install libpam-google-authenticator

# Google Authenticator starten
  google-authenticator

fi
