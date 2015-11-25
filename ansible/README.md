# Server setup with Ansible
Ansible is a free software platform for configuring and managing computers.
It combines multi-node software deployment, ad hoc task execution, and configuration management.
## Ansible setup
On debian
```
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible sshpass
```

## Managed Node Requirements
On the managed nodes, you need a way to communicate, normally ssh.
By default Ansible uses sftp, if not available you can switch to scp in ansible.cfg.
Also you need Python 2.4 or later, but if you are running less than Python 2.5 on the remotes, you will also need:
```
python-simplejson
```

## Setup of Node servers
1. Register node servers in `/etc/ansible/hosts`
2. Test communication with node servers
```
ansible all -m ping --user=XXXXXX --vault-password-file=.p --sudo --ask-sudo-pass
```
or (better) with private key authentification
```
ansible all -m ping --user=XXXXXX --private-key=p.key --sudo --ask-sudo-pass
```

3. Play a playbook
```
ansible-playbook mysql_server_setup.yml [+authentification options]
```

# Structure of the repository
- defaults:
default variables used by a role

- files:
files that need to be added to the machine being provisioned, without modification

- handlers:
handlers usually contain targets for notify directives

- meta:
The metadata of an Ansible role consists of attributes such as author, supported platforms, and dependencies.

- tasks:
Series of Ansible plays to install, configure, and run software.

- templates:
files that may be modified (Jinja2 template engine)

- vars:
variables with high priority
