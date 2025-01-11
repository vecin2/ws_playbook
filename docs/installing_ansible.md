## Installing Ansible

Ansible can be installed via the Ubuntu APT package manager or via `pip`.

### Installing using the Ubuntu APT Package Manager
It is recommended to add the PPA to get a more up-to-date version of Ansible.

```bash
sudo apt update
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
By default, Ansible will use the system's Python 3 version. For example, if which python3 resolves to Python 3.12, Ansible will use Python 3.12.

### Installing from pip

To install the latest version of Ansible, you can use pip.

```bash
pip install ansible
```
Ansible will use the Python version associated with the pip command. For this reason, it is recommended to install Ansible within a Python virtual environment. This allows you to select the Python version you wish to use and install Ansible with pip in that isolated environment.

Currently we are managing python environments with virtualenvwrapper.
