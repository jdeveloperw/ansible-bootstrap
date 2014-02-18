ansible-bootstrap
=================

Minimal scripts and files needed to allow ansible to manage a server.

## Files

<pre>
ansible-bootstrap/
├── README.md
|   This file
├── RUNME.sh
|   Standalone script that can be downloaded and run to configure a server to be managed by ansible
├── ansible-bootstrap.sh
|   Does most of the work of setting up the server to be managed by ansible.
├── sshd_config
|   Copied to /etc/ssh/sshd_config by ansible-bootstrap.sh
└── sudoers-ansible
    Copied to /etc/sudoers.d/ansible/ by ansible-bootstrap.sh
</pre>

## Setting up a server to be managed by ansible

### Definitions

controller := the computer running the ansible-playbook command

controllee := the computer that ansible manages

### Procedure

This assumes you are setting up a Ubuntu 13.10 x64 to be managed by ansible.

- Controller: Create a public/private key pair and copy it from the controller to the controllee's `/root` directory

        ssh-keygen -f ~/.ssh/ansible
        scp ~/.ssh/ansible.pub root@$MYSERVER:/root/

- Controllee: Download and run `RUNME.sh`
  
        wget https://raw2.github.com/jdeveloperw/ansible-bootstrap/master/RUNME.sh
        sh RUNME.sh

  NOTE: This will disable password-based on authentication on the controllee,
  requiring you to login to the controllee as `ansible@$MYSERVER` using the `~/.ssh/ansible` private key.
  If you want to re-enable password-based authentication, edit `/etc/ssh/sshd_config`, replacing

        PasswordAuthentication no

  with

        PasswordAuthentication yes

- Controller: ssh to the controllee as ansible

         ssh ansible@$MYSERVER -i ~/.ssh/ansible
