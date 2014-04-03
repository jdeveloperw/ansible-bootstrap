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

cd /root
$PACKAGE_MANAGER install git
git clone https://github.com/jdeveloperw/ansible-bootstrap.git
mv ansible.pub ansible-bootstrap/
cd ~/ansible-bootstrap/
./ansible-bootstrap.sh
