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
apt-get install -y git gcc g++ make
mkdir work
sleep 5

echo
echo ------------------------*
echo Settin\' up MySQL
echo ------------------------*
echo

apt-get install -y mysql-server libmysqlclient-dev

echo "Initializing the MySQL btcratio user. Executing the following command. Use the 'root' password."
echo 
echo "cd ~/apps/btcltcratio && mysql -u root -p < ./install/init_btcratio_db.sql"
bash -c "cd ~/apps/btcltcratio && mysql -u root -p < ./install/init_btcratio_db.sql"

echo ------------------------*
echo Settin\' up sqlite3
echo ------------------------*
echo

apt-get install -y libsqlite3-dev


echo -------------------------------*
echo Settin\' up Passenger and Nginx
echo -------------------------------*
echo

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list
chown root: /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list
apt-get update
apt-get install -y nginx-extras passenger
rm /usr/bin/ruby
ln -s /usr/local/bin/ruby /usr/bin/ruby

sed -i -e 's/# pass/pass/g' /etc/nginx/nginx.conf
sed -i -e 's/listen 80 default_server/# listen 80 default_server/g' /etc/nginx/sites-available/default
sed -i -e 's/listen [::]:80 default_server ipv6only=on/# listen [::]:80 default_server ipv6only=on/g' /etc/nginx/sites-available/default

echo ------------------------*
echo Settin\' up node.js
echo ------------------------*
echo
cd ~/work
apt-get install -y clang-3.5 
curl -# -L  curl -# -L https://nodejs.org/dist/v4.1.2/node-v4.1.2.tar.gz > node-v4.1.2.tar.gz
tar -xvf node-v4.1.2.tar.gz
mv node-v4.1.2 ~/apps
cd ~/apps/node-v4.1.2
./configure
make
make install

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
#sleep 5

echo ------------------------*
echo Settin\' up Ruby
echo ------------------------*
echo

cd ~/work
apt-get install -y libgdbm-dev libssl-dev libreadline-dev
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

gem install --no-rdoc --no-ri rails

cd ~/apps/btcltcratio
bundle install

rake db:reset
chown btcratio log/development.log

echo ---------------------------------------*
echo Settin\' up the other btcratio projects
echo ---------------------------------------*
echo

cd ~/apps
git clone https://github.com/haxwell/btcratio_gem.git
cd ~/apps/btcratio_gem
gem uninstall btcratio
gem build btcratio.gemspec
gem install btcratio

cd ~/apps
git clone https://github.com/haxwell/btcratio_view.git
cd ~/apps/btcratio_view
sed -i -e "s/# gem \'therubyracer\'/gem \'therubyracer\'/g" Gemfile
bundle install

echo "server {
listen 80 default_server;
passenger_enabled on;
passenger_app_env development;
root /home/btcratio/apps/btcratio_view/public;
}" > /etc/nginx/sites-available/btcratio_view

ln -s /etc/nginx/sites-available/btcratio_view /etc/nginx/sites-enabled/btcratio_view


