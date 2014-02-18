#!/bin/sh

if [[ `cat /proc/version | grep -i 'red hat'` ]]; then
  DISTRIBUTION='RHEL'
else
  DISTRIBUTION=''
fi

if [ $DISTRIBUTION == 'RHEL' ]; then
  PACKAGE_MANAGER="yum"
else
  PACAKGE_MANAGER="apt-get"
fi

sudo cd /root
sudo $PACKAGE_MANAGER install git
sudo git clone https://github.com/jdeveloperw/ansible-bootstrap.git
sudo mv ansible.pub ansible-bootstrap/
sudo cd ~/ansible-bootstrap/
sudo ./ansible-bootstrap.sh
