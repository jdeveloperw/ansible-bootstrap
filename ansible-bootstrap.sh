#!/bin/sh

if [[ `cat /proc/version | grep -i 'red hat'` ]]; then
  DISTRIBUTION='RHEL'
else
  DISTRIBUTION=''
fi

if [ $DISTRIBUTION == 'RHEL' ]; then
  SSHD_SERVICE="sshd"
else
  SSHD_SERVICE="ssh"
fi

sudo useradd ansible
sudo mkdir -p /etc/sudoers.d
sudo cp sudoers-ansible /etc/sudoers.d/ansible
sudo cp sshd_config /etc/ssh/sshd_config
sudo service $SSHD_SERVICE restart
sudo mkdir -p /home/ansible
sudo chown ansible /home/ansible
sudo chgrp ansible /home/ansible

sudo -u ansible -H mkdir -p /home/ansible/.ssh
sudo -u ansible -H chmod 700 /home/ansible/.ssh
sudo -u ansible -H cp ansible.pub /home/ansible/.ssh/authorized_keys
sudo -u ansible -H chmod 644 /home/ansible/.ssh/authorized_keys
