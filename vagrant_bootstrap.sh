#!/bin/bash

# pour le proxy à polytechnique, lignes à décommenter si vous y êtes

# export HTTP_PROXY="http://129.104.247.2:8080"
# export HTTPS_PROXY="http://129.104.247.2:8080"
# echo 'Acquire::http::Proxy "http://129.104.247.2:8080/";' >> /etc/apt/apt.conf

export DEBIAN_FRONTEND=noninteractive
export LINE_BREAK_UP="

###########################################
#"
export LINE_BREAK="#
###########################################"


######################## BACK END ######################################
echo "${LINE_BREAK_UP}"
echo '# 1/6 Backend setup - apt packages'
echo "${LINE_BREAK}"

sudo apt-get update
sudo apt-get -yqq install git python3-pip python-dev libmysqlclient-dev libjpeg-dev \
  build-essential apt-transport-https

cd /vagrant/backend
echo "from .settings_default import *

DEBUG = True

class contains_all_list(list):
    def __contains__(self, key):
        return True

INTERNAL_IPS = contains_all_list()" > sigma/settings.py

echo "${LINE_BREAK_UP}"
echo '# 2/6 Backend setup - pip requirements'
echo "${LINE_BREAK}"

sudo chown -R vagrant:vagrant /vagrant/backend
pip3 install -r requirements/dev.txt
pip3 install -r requirements/prod.txt

echo "${LINE_BREAK_UP}"
echo '# 3/6 Backend setup - Migrations'
echo "${LINE_BREAK}"

python3 manage.py migrate


######################## FRONT END ######################################
echo "${LINE_BREAK_UP}"
echo '# 4/6 Frontend setup - apt packages'
echo "${LINE_BREAK}"

curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
DISTRO="vivid"
echo "deb https://deb.nodesource.com/node_5.x ${DISTRO} main" > /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/node_5.x ${DISTRO} main" >> /etc/apt/sources.list.d/nodesource.list
apt-get install -yqq nodejs npm

cd /vagrant/frontend
# Remove old modules from previous install / host machine
sudo rm -rf node_modules


echo "${LINE_BREAK_UP}"
echo '# 5/6 Frontend setup - TSD & GULP'
echo "${LINE_BREAK}"
sudo HTTPS_PROXY=$HTTPS_PROXY npm install -g tsd gulp


echo "${LINE_BREAK_UP}"
echo '# 6/6 Frontend setup - npm packages'
echo "${LINE_BREAK}"
sudo -H -u vagrant HTTPS_PROXY=$HTTPS_PROXY npm install --loglevel=info

echo ""
echo "Vagrant install complete."
echo "Now try logging in:"
echo "    $ vagrant ssh"

