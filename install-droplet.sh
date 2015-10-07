#! /bin/bash

# Assumptions:
#  a user with sudo privilege named 'btcratio' exists

# This script should be run as sudo
if [ "$(id -u)" != 0 ]; then
    echo "You should run this as root."
    exit 1
fi

echo ------------------------*
echo Doin\' setup stuff
echo ------------------------*
echo

cd ~
apt-get update 
#apt-get install -y unzip git dpkg-dev authbind
#mkdir work
sleep 5

echo ------------------------*
echo Settin\' up MySQL
echo ------------------------*
echo

apt-get install -y mysql-server

echo "Initializing the MySQL btcratio user. Executing the following command. Use the 'root' password."
echo 
echo "cd ~/apps/btcltcratio && mysql -u root -p < ./install/init_btcratio_db.sql"
bash -c "cd ~/apps/btcltcratio && mysql -u root -p < ./install/init_btcratio_db.sql"

echo ------------------------*
echo Settin\' up Ruby
echo ------------------------*
echo

echo ------------------------*
echo Settin\' up Rails
echo ------------------------*
echo

