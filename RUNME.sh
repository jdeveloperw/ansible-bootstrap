#!/bin/sh

sudo su
cd /root
sudo apt-get install git
git clone https://github.com/jdeveloperw/ansible-bootstrap.git
mv ansible.pub ansible-bootstrap/
cd ~/ansible-bootstrap/
./ansible-bootstrap.sh
