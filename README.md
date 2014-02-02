ansible-bootstrap
=================

Minimal scripts and files needed to allow ansible to manage a server.

## Setting up a server to be managed by ansible

### Definitions

controller := the computer running the ansible-playbook command

controllee := the computer that ansible manages

### Procedure

This assumes you are setting up a Ubuntu 13.10 x64 to be managed by ansible.

- Controller: Create a public/private key pair and copy it from the controller to the controllee's `/root` directory

        ssh-keygen -f ~/.ssh/ansible
        scp ~/.ssh/ansible.pub root@$MYSERVER:/root/ansible-bootstrap/

- Controllee: Download and run `RUNME.sh`
  
        wget https://raw2.github.com/jdeveloperw/ansible-bootstrap/master/RUNME.sh
        ./RUNME.sh
