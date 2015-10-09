#! /bin/bash

# Assumptions:
#  a user with sudo privilege named 'btcratio' exists

# This script should be run as sudo
if [ "$(id -u)" != 0 ]; then
    echo
    echo "You should run this as root."
    echo
    exit 1
fi

echo ------------------------*
echo Doin\' setup stuff
echo ------------------------*
echo

cd ~
apt-get update 
apt-get install -y git gcc make libgdbm-dev 
mkdir work
sleep 5

echo
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
echo Settin\' up zlib
echo ------------------------*
echo

cd work
curl -# -L  http://zlib.net/zlib-1.2.8.tar.gz > zlib-1.2.8.tar.gz
tar -xvf zlib-1.2.8.tar.gz
mv zlib-1.2.8 ~/apps
cd ~/apps/zlib-1.2.8
./configure
make
make install
echo 
echo Completed zlib setup....
sleep 5

echo ------------------------*
echo Settin\' up Ruby
echo ------------------------*
echo

cd ~/work
curl -# -L https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.bz2 > ruby-2.2.3.tar.bz2
tar -xvf ruby-2.2.3.tar.bz2
mv ruby-2.2.3 ~/apps
cd ~/apps/ruby-2.2.3
./configure
make
make install

echo ------------------------*
echo Settin\' up Rails
echo ------------------------*
echo

