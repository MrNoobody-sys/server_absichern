# Server absichern für Ubuntu 18.04

## Bitte als erstes einen neuen Benutzer anlegen

    sudo adduser BENUTZER
    sudo usermod -aG sudo BENUTZER
    su BENUTZER

## Install
1. git clone https://github.com/Nazaled/server_absichern.git
2. cd server_absichern
4. sudo bash ./serversafe.sh

### Apticron
1. Bitte tragen Sie unter "EMAIL=root" ihre E-Mail Adresse ein

### Root für SSH Login sperren
1. suchen Sie "PermitRootLogin yes" und ändern Sie es auf "PermitRootLogin no"

### Google Authenticator
1. Bitte beantworten Sie die Fragen wie folgt:

Do you want authentication tokens to be time-based (y/n) y

Do you want me to update your "~/.google_authenticator" file (y/n) y

Do you want to disallow multiple uses of the same authentication
token? This restricts you to one login about every 30s, but it increases
your chances to notice or even prevent man-in-the-middle attacks (y/n) y

By default, tokens are good for 30 seconds and in order to compensate for
possible time-skew between the client and the server, we allow an extra
token before and after the current time. If you experience problems with poor
time synchronization, you can increase the window from its default
size of 1:30min to about 4min. Do you want to do so (y/n) n

If the computer that you are logging into isn't hardened against brute-force
login attempts, you can enable rate-limiting for the authentication module.
By default, this limits attackers to no more than 3 login attempts every 30s.
Do you want to enable rate-limiting (y/n) y

2. Suchen Sie nun "@include common-password" und schreiben Sie da drunter "auth required pam_google_authenticator.so"

. . .
@include common-password
auth required pam_google_authenticator.so

3. Suchen Sie als nächstes "ChallangeResponseAuthentication no" und ändern Sie es auf "ChallangeResponseAuthentication yes"



