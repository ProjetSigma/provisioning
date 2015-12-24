#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
echo 'Installing required packages...'
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
DISTRO="vivid"
sudo sh -c "echo 'deb https://deb.nodesource.com/node_5.x ${DISTRO} main' > /etc/apt/sources.list.d/nodesource.list"
sudo sh -c "echo 'deb-src https://deb.nodesource.com/node_5.x ${DISTRO} main' >> /etc/apt/sources.list.d/nodesource.list"

sudo apt-get update
sudo apt-get -yqq install git python3-pip python-dev libmysqlclient-dev libjpeg-dev \
  build-essential apt-transport-https nodejs

cd /vagrant/backend
echo 'Installing pip dependencies...'
sudo pip3 install -r requirements/dev.txt
sudo pip3 install -r requirements/prod.txt
echo "Running migrations..."
python3 manage.py migrate

cd /vagrant/frontend
# Remove old modules from previous install / host machine
sudo rm -rf node_modules
sudo npm install -g tsd gulp
sudo -H -u vagrant npm install --loglevel=info

echo ""
echo "Vagrant install complete."
echo "Now try logging in:"
echo "    $ vagrant ssh"

