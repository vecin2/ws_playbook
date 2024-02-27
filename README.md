# Introduction

This repository intends to help setting my wsl environment within a Windows 10 machine.

The first step will be to install wsl on windows 10 so git is available. To do that run the following commands:

wsl --list --online #will return the list of available distrution names

wsl --install -d <<distribution_name>>

\*\* In a corporate laptop make sure to run it as an admin from `cmd` and not powershell. Powershell gives a priviledges error.

# Upgrading WSL

Every so ofter run wsl --update to make sure we are running latest

# Steps

## Installing Ansible

After installing WSL we need to install Ansible on WSL. 
Ansible can run against different python versions.

Installing ansible from python. It will make ansible using the python version that was installed from
```python3 -m pip ansible```

Installing ansible with apt:
```
sudo apt update
sudo apt install software-properties-common
#No need to add repostory in ubuntu 20.04
#sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
Installing ansible using apt, makes ansible use the python3 versionthat is configured. If `python3` points to 3.8 will use 3.8, if it points to 3.10 it will use 3.10


## Set-up ssh key

- Create key account silently
  ssh-keygen -t ed25519 -C vecin2@gmail.com -f ~/.ssh/id_ed25519_vecin2 -P ""

Open pub file a copy account and add it to your github profile
notepad.exe ~/.ssh/id_ed25519_vecin2.pub

- Start ssh-agent and add key. Run [setup_ssh_key.sh](./setup_ssh_key.sh) passing file name.

- [Install ansible](./install_ansible.sh)
- Open playbook [linux_ws.yml](./linux_ws.yml) and review the tasks that will be installed
- Run [wsl-playbook](./run_linux_playbook.sh)

## Windows

- Install chocolatey if not installed
- From an admin cmd install the following choco packages:

```
# For EM development

choco install -y tortoisesvn virtualbox vagrant

# Basic Packages
choco install -y notepadplusplus
```

### Allow WSL .bat Execute

Run the following command:
`sudo sh -c "echo :WindowsBatch:E::bat::/init: > /proc/sys/fs/binfmt_misc/register"`

Do not put on rc file as it prompts for password and it is no required to run everytime (maybe its required after each restart)

# Ansible in Ubuntu

Having cargo module on ansible requires having later version allows using ansible-galaxy collect list
To get the latest ansible version we need to add the ansible repository to apt:
sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible

Add community collection, used to install cargo packages

# Setup Clipboard on WSL2

- choco install vcxsrv
- WSL2 uses a different network setup the following line within you rc file
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

- Run C:/Program Files/VcXsrv/xlaunch.exe:
  - Multiple windows
  - Start no client
  - Clipboard/Native Opengl/Disable Access Control (all three ticked)
  - Save config to starup folder so it runs on start
  - Startup folderi
    - Windows key + r: shell: Startup
    - C:\Users\dgarcia\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

Also because it a external address the xlaunch configuration needs to have checked Disable Access Control so it accepts conexions

# NerdFonts

Copy ./files/Caskadia Cove Nerd Font Complete Windows Compatible.tff into your desktop. Open it and install it.
Copying nerdfonts into `c:\windows\Fonts` might give permission issues.
Change nerdfonts path to something that does ont give pemisission error and then copy manually from windows
Current windows terminal `files/settings.json` is pointing to the font so web-devicons are working on the terminal.

# ws_playbook

Ansible playbook to confire my dev work station.
Run it with `ansible-playbook local.yml -K` and enter the WSL sudo password.
Make sure this var is exported: export ANSIBLE_VAULT_PASSWORD_FILE=$HOME/vault_password.txt

#Install on ubuntu
ag silver searcher so FZF Ctrl+t works

# Manual Steps on Windows

# Configuring a Windows 10 Vagrant box on Windows 10 Host

Windows 10 box runs really slow. Thats related to Hyper-v still running an VirtualBox ends up using it. To turn off Hyper-v run the following command as an admin from the cmd:
bcdedit /set hypervisorlaunchtype off

The issue then is that WSL2 wont start
https://github.com/MicrosoftDocs/WSL/issues/798

# VirtualBox Set static address

Some vagrant boxes, like oracle 19.3, configure VirtualBox to use a NAT network only. Then they use port forwarding on 1521 from localhost into the VirtualBox machine. However, this approach doesn't work when accessing from WSL. We have to use static ip address.

This [article](https://marcus.4christies.com/2019/01/how-to-create-a-virtualbox-vm-with-a-static-ip-and-internet-access/) describes how to implement, at least for fedora linux system, which is the one used by the [oracle19.3](https://github.com/oracle/vagrant-projects) vagant box. Main section from that article:

Create a file called ifcfg-enp0s8 in `/etc/sysconfig/network-scripts/` and give it the following contents:

DEVICE=enp0s8
BOOTPROTO=static
ONBOOT=yes
IPADDR=192.168.99.10
NETMASK=255.255.255.0
Where NETMASK should match the settings for your host-only network as obtained above and IPADDR should be an available IP address in the host-only network (again, typically in 2-254 range).

Now run `systemctl restart network`

### Vim with CoC

Disable plugins: mi
Search word on cwi: <space>g
Search word under cursor on cwi: <space>ag
Open File: <space>t
Open Buffer: <space>b

#### Fix Vim xClip

Download vcxsrv
Run installer using default options
Run vcxsrv using "xlaunch" (search in the start menu)
Add export DISPLAY=localhost:0.0 to your wsl bashrc

#### WSL2

WSL2 uses a different network so instead we should use:
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

Also because it a external address the xlaunch configuration needs to have checked Disable Access Control so it accepts conexions

###Python
Install python 3.5.7
Install pip install virtualenvwrapper-win

##packages
x - install vim
configure vim as in linux
choco install wsltty
vlc -video

#Windows
Remove bell on the command line/WSL
Install spanish language
copy text from tmux ctrl [ and then paste in vim
paste in vim with "+ not working

### EM Machina

choco install virtualbox
choco install vagrant

##in wsl run
sudo apt-get install subversion

### Run in WSL vs WSL2

WSL shares the network with the Windows Host while WSL2 has its own network.
when running playbooks against the windows host this translates in WSL being able to use "localhost" while WSL2 will have to specify the Windows Host ip address within the Hyper-V WSL network.

In a "worklaptop_WSL" I want to set the var ansible_python_interpreter put it into inventory

Vim
Syntastic and Nerdtree git failed when saving python files if the file was not open with nerdtree
In case this issue has not been fixed, there is a workaround:

Add to nerdtree-git-plugin/nerdtree_plugin/git_status.vim:
augroup nerdtreegitplugin
autocmd BufWritePost \* call s:FileUpdate(expand("%:p"))
augroup END

Before:
" FUNCTION: s:FileUpdate(fname) {{{2
function! s:FileUpdate(fname)

# EM_AUTOMATION

Running in wsl/ubuntu need libaio1 package and oracle instant client
Then set env var:
export LD_LIBRARY_PATH=/usr/lib/oracle/<version>/client(64)/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

# Conect to windows host from WSL2

Runnign ipconfig on windows will give a wsl ethernet adapter get ip from there e.g 172.24.128.1

# Tmux

Install tmux plugin by running Ctrl+a+I
