# ws_playbook
Ansible playbook to confire my dev work station.
Run it with `ansible-playbook local.yml -K` and enter the WSL sudo password.

#Install on ubuntu
ag silver searcher so FZF Ctrl+t works

# Manual Steps on Windows

# Configuring a Windows 10 Vagrant box on Windows 10 Host

Windows 10 box runs really slow. Thats related to Hyper-v still running an VirtualBox ends up using it. To turn off Hyper-v run the following command as an admin from the cmd:
bcdedit /set hypervisorlaunchtype off

The issue then is that WSL2 wont start
https://github.com/MicrosoftDocs/WSL/issues/798


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
sudo apt-get install  subversion

### Run in WSL vs WSL2
WSL shares the network with the Windows Host while WSL2 has its own network.
when running playbooks against the windows host this translates in WSL being able to use "localhost" while WSL2 will have to specify the Windows  Host ip address within the Hyper-V WSL network.

In a "worklaptop_WSL" I want to set the var ansible_python_interpreter put it into inventory


Vim
Syntastic and Nerdtree git failed when saving python files if the file was not open with nerdtree
In case this issue has not been fixed, there is a workaround:

Add to nerdtree-git-plugin/nerdtree_plugin/git_status.vim:
augroup nerdtreegitplugin
    autocmd BufWritePost * call s:FileUpdate(expand("%:p"))
augroup END

Before:
" FUNCTION: s:FileUpdate(fname) {{{2
function! s:FileUpdate(fname)



##EM_AUTOMATION
Running in wsl/ubuntu need libaio1 package and oracle instant client
Then set env var:
export LD_LIBRARY_PATH=/usr/lib/oracle/<version>/client(64)/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

# Conect to windows host from WSL2
Runnign ipconfig on windows will give a wsl ethernet adapter get ip from there e.g 172.24.128.1
