#!/bin/sh

SUDOERS_ANSIBLE_CONTENT="
# Allow ansible user sudo access without a password prompt
ansible ALL=(ALL)       NOPASSWD:ALL
"

SSHD_CONFIG_EXTRA_CONTENT="
# Enable PubkeyAuthentication
PubkeyAuthentication yes

# Disable PasswordAuthentication
PasswordAuthentication no
"

SSHD_CONFIG_FILE='/etc/ssh/sshd_config'
ANSIBLE_HOME='/ansible'


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

# Make sure we are in root's home directory
cd /root

# Create the ansible user
useradd ansible --home=$ANSIBLE_HOME

# Give ansible user permissions to run as root without a password prompt
mkdir -p /etc/sudoers.d
echo -e "$SUDOERS_ANSIBLE_CONTENT" > /etc/sudoers.d/ansible
chmod 440 /etc/sudoers.d/ansible

# Enable public key authentication and disable password authentication
# Remove any existing references to PasswordAuthentication
sed -i "s/.*PasswordAuthentication.*//g" $SSHD_CONFIG_FILE
# Remove any existing references to PubkeyAuthentication
sed -i "s/.*PubkeyAuthentication.*//g" $SSHD_CONFIG_FILE
# Write the configuration we want to the sshd config file
echo -e "$SSHD_CONFIG_EXTRA_CONTENT" >> $SSHD_CONFIG_FILE
service $SSHD_SERVICE restart

# Create home directory for the ansible user
mkdir -p $ANSIBLE_HOME
chown ansible $ANSIBLE_HOME
chgrp ansible $ANSIBLE_HOME

# Add ansible.pub to the ansible user's authorized keys
cp /root/ansible.pub /tmp
sudo -u ansible -H mkdir -p $ANSIBLE_HOME/.ssh
sudo -u ansible -H chmod 700 $ANSIBLE_HOME/.ssh
sudo -u ansible -H cp /tmp/ansible.pub $ANSIBLE_HOME/.ssh/authorized_keys
sudo -u ansible -H chmod 644 $ANSIBLE_HOME/.ssh/authorized_keys
