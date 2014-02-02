#!/bin/sh

sudo su
cd /root/
useradd ansible
cp sudoers-ansible /etc/sudoers.d/ansible
cp sshd_config /etc/ssh/sshd_config
service ssh restart
mkdir -p /home/ansible
chown ansible /home/ansible
chgrp ansible /home/ansible

sudo -u ansible -H mkdir -p /home/ansible/.ssh
sudo -u ansible -H chmod 700 /home/ansible/.ssh
sudo -u ansible -H cp ansible.pub /home/ansible/.ssh/authorized_keys
sudo -u ansible -H chmod 644 /home/ansible/.ssh/authorized_keys
