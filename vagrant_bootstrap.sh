#!/bin/bash
echo 'Installing required packages...'
sudo apt-get -yqq install git python3-pip python-dev libmysqlclient-dev libjpeg-dev

cd /vagrant/backend
echo 'Installing pip dependencies...'
sudo pip3 install -r requirements.txt
echo "Running migrations..."
python3 manage.py migrate

# Todo: install npm; build app
# cd /vagrant/frontend


echo ""
echo "Vagrant install complete."
echo "Now try logging in:"
echo "    $ vagrant ssh"
