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

useradd ansible
mkdir -p /etc/sudoers.d
cp sudoers-ansible /etc/sudoers.d/ansible
cp sshd_config /etc/ssh/sshd_config
service $SSHD_SERVICE restart
mkdir -p /home/ansible
chown ansible /home/ansible
chgrp ansible /home/ansible

sudo -u ansible -H mkdir -p /home/ansible/.ssh
sudo -u ansible -H chmod 700 /home/ansible/.ssh
sudo -u ansible -H cp ansible.pub /home/ansible/.ssh/authorized_keys
sudo -u ansible -H chmod 644 /home/ansible/.ssh/authorized_keys
