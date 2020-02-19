#!/bin/bash

clear
echo
echo -e "\t\033[1;34m SAFEGUARD \033[0m"
echo -e "\t\033[1;34m ========= \033[0m"
echo
echo -e "\t\033[1;32m # \033[0m Do you want to secure the server now? Yes\033[1;32m[y]\033[0m No\033[1;32m[n]\033[0m \c"
read secure

if [[ "$secure" = "y" || "$secure" = "Y" ]]; then

	# # # UPDATE & UPGRADE # # #

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"

	echo -e "\t\033[1;33m Update & Upgrade \033[0m"
	echo
	echo -e "\t The server is updated now! "
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo apt update && sudo apt upgrade -y

	# # # APTICRON # # #

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo
	echo -e "\t\033[1;33m Apticron \033[0m"
	echo
	echo -e "\t The server installs apticron now! "
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo apt install apticron -y

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo 
	echo -e "\t\033[1;33m Apticron \033[0m"
	echo
	echo -e "\t Apticron will send you emails when a new update is available for the server."
	echo -e "\t What email address should apticron use?"
	echo
	echo -e "\t Email : \c"
	read EMAIL
	sudo sed -i "/^EMAIL=/s/=.*/=$EMAIL/" /etc/apticron/apticron.conf       

	# # # SSH # # #

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo 
	echo -e "\t\033[1;33m SSH \033[0m"
	echo
	echo -e "\t The ssh port is changed to 60200."
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo sed -i "s/#Port 22/Port 60200/" /etc/ssh/sshd_config
	echo
	echo -e "\t Access to root is prohibited."
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo sed -i "/^PermitRootLogin/s/yes/no/" /etc/ssh/sshd_config

	# # # S-NAIL # # #

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo 
	echo -e "\t\033[1;33m S-NAIL \033[0m"
	echo
	echo -e "\t The server installs S-Nail now."
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo apt install s-nail -y

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo 
	echo -e "\t\033[1;33m S-NAIL \033[0m"
	echo
	echo -e "\t A template of the email will be created."
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo touch /opt/shell-login.sh
	sudo chmod 755 /opt/shell-login.sh
	sudo chown $USER:$USER /opt/shell-login.sh
	HEADING=#!/bin/bash
	sudo echo -e "$HEADING\necho "Login auf '$(hostname)'"\necho "am '$(date +%Y-%m-%d)'"\necho "um '$(date +%H:%M)'"\necho "Benutzer: '$USER'"" >> /opt/shell-login.sh
	sudo chown root:root /opt/shell-login.sh
	echo
	echo -e "\t In order to send an email with an ssh login, a connection to /etc/profile must be established."
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo chown $USER:$USER /etc/profile
	echo -e "/opt/shell-login.sh | mailx -s \"SSH Login auf \$USER\" $EMAIL" >> /etc/profile
	sudo chown root:root /etc/profile

	# # # GOOGLE AUTHENTICATOR # # #

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo 
	echo -e "\t\033[1;33m Google Authenticator \033[0m"
	echo
	echo -e "\t The server installs Google Authenticator now!"
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo apt install libpam-google-authenticator -y

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo 
	echo -e "\t\033[1;33m Google Authenticator \033[0m"
	echo
	echo -e "\t After the start you will be asked a few questions."
	echo
	echo -e "\t Make tokens "time-base": \033[1;32m no \033[0m"
	echo -e "\t Update the .google_authenticator file: \033[1;32m yes \033[0m"
	echo -e "\t Disallow multiple uses: \033[1;32m yes \033[0m"
	echo -e "\t Increase the original generation time limit: \033[1;32m no \033[0m"
	echo -e "\t Enable rate-limiting: \033[1;32m yes \033[0m"

	echo
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	google-authenticator

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo 
	echo -e "\t\033[1;33m Google Authenticator \033[0m"
	echo
	echo -e "\t To make SSH use the Google Authenticator PAM module, something has to be changed in /etc/pam.d/sshd."
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo chown $USER:$USER /etc/pam.d/sshd
	sudo sed -i "/^@include common-password/aauth required pam_google_authenticator.so" /etc/pam.d/sshd
	sudo chown root:root /etc/pam.d/sshd
	echo
	echo -e "\t Finally, authentication has to be allowed."
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo sed -i "s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/" /etc/ssh/sshd_config

	# # # FINISH # # #

	clear
	echo
	echo -e "\t\033[1;34m SAFEGUARD \033[0m"
	echo -e "\t\033[1;34m ========= \033[0m"
	echo 
	echo -e "\t\033[1;33m Finish \033[0m"
	echo
	echo -e "\t After you press enter a restart is made."
	echo
	echo -e "\t\033[1;33m Have fun! \033[0m"
	echo
	echo -e "\t\033[1;32m # \033[0m Press enter to continue \c"
	read
	sudo reboot now
	clear

elif [[ "$secure" = "n" || "$secure" = "N" ]]; then

	clear
	exit

fi
