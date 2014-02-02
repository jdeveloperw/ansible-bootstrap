ansible-bootstrap
=================

Minimal scripts and files needed to allow ansible to manage a server.

## Setting up a server to be managed by ansible

This assumes you are setting up a Ubuntu 13.10 x64 to be managed by ansible.

- Create a public/private key pair on the computer you will be using to run ansible (controller)

        ssh-keygen -f /root/.ssh/ansible

- As root, clone the ansible-bootstrap repo on the server that will be managed by ansible (controllee)

        cd
        git clone git@github.com:jdeveloperw/ansible-bootstrap.git

- On the controller, copy the ansible public key from the controller to the controllee's ansible-bootstrap repo

        scp ~/.ssh/ansible.pub $MYSERVER:/root/ansible-bootstrap/

- On the controllee, run the bootstrap script

        cd ~/ansible-bootstrap/
        ./ansible-bootstrap.sh
