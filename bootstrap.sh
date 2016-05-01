#!/usr/bin/env bash

sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

printf "%$(tput cols)s\n"|tr " " "="
echo "Starting provisioning (Update list packages)"
printf "%$(tput cols)s\n"|tr " " "="
apt-get update

printf "%$(tput cols)s\n"|tr " " "="
echo "Installing Apache and its modules"
printf "%$(tput cols)s\n"|tr " " "="
apt-get install -y apache2
apt-get install -y php5
apt-get install -y php5-xdebug
echo "Apache configuration for Vagrant"
if ! [ -L /var/www ]; then
  rm -rf /var/www/*
  ln -fs /vagrant /var/www/html
fi

printf "%$(tput cols)s\n"|tr " " "="
echo "Installing Git and dev tools"
printf "%$(tput cols)s\n"|tr " " "="
apt-get install -y git

printf "%$(tput cols)s\n"|tr " " "="
echo "Provisioning completed"
printf "%$(tput cols)s\n"|tr " " "="
