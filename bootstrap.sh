#!/usr/bin/env bash

sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
sed -i '/^#.*force_color_prompt=yes/s/^#//' ./.bashrc
echo "cd /var/www/html/" >> ./.bashrc

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


printf "%$(tput cols)s\n"|tr " " "="
echo "Installing MySql"
printf "%$(tput cols)s\n"|tr " " "="
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password vagrant'
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql


printf "%$(tput cols)s\n"|tr " " "="
echo "Configuring Apache for Vagrant"
printf "%$(tput cols)s\n"|tr " " "="
if ! [ -L /var/www ]; then
  rm -rf /var/www/*
  ln -fs /vagrant /var/www/html
fi
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
a2enmod rewrite
#Configuring XDebug
echo "zend_extension=xdebug.so">/etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_enable = on">>/etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = on">>/etc/php5/mods-available/xdebug.ini

service apache2 restart

printf "%$(tput cols)s\n"|tr " " "="
echo "Installing Git and dev tools"
printf "%$(tput cols)s\n"|tr " " "="
apt-get install -y git

printf "%$(tput cols)s\n"|tr " " "="
echo "Provisioning completed"
printf "%$(tput cols)s\n"|tr " " "="
