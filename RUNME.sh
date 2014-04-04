#!/bin/sh

SUDOERS_ANSIBLE_CONTENT='
# Allow ansible user sudo access without a password prompt\n
ansible ALL=(ALL)       NOPASSWD:ALL'

SSHD_CONFIG_EXTRA_CONTENT='
# Enable Public Key Authentication\n
PubkeyAuthentication yes\n
\n
# Disable password Authentication\n
PasswordAuthentication no\n
'

SSHD_CONFIG_FILE='/etc/ssh/sshd_config'


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

# Make sure when are in root's home directory
cd /root

# Create the ansible user
useradd ansible

# Give ansible user permissions to run as root without a password prompt
mkdir -p /etc/sudoers.d
echo $SUDOERS_ANSIBLE_CONTENT > /etc/sudoers.d/ansible

# Enable public key authentication and disable password authentication
# Remove any existing references to PasswordAuthentication
sed -i "s/.*PasswordAuthentication.*//g" $SSHD_CONFIG_FILE
# Remove any existing references to PubkeyAuthentication
sed -i "s/.*PubkeyAuthentication.*//g" $SSHD_CONFIG_FILE
# Write the configuration we want to the sshd config file
echo $SSHD_CONFIG_CONTENT >> $SSHD_CONFIG_FILE
service $SSHD_SERVICE restart

# Create home directory for the ansible user
mkdir -p /home/ansible
chown ansible /home/ansible
chgrp ansible /home/ansible

# Add ansible.pub to the ansible user's authorized keys
sudo -u ansible -H mkdir -p /home/ansible/.ssh
sudo -u ansible -H chmod 700 /home/ansible/.ssh
sudo -u ansible -H cp /root/ansible.pub /home/ansible/.ssh/authorized_keys
sudo -u ansible -H chmod 644 /home/ansible/.ssh/authorized_keys
