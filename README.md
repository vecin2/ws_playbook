# ws_playbook
Ansible playbook to confire my dev work station. 
Run it with `ansible-playbook local.yml -K` and enter the WSL sudo password.

#Install on ubuntu
ag silver searcher so FZF Ctrl+t works

# Manual Steps on Windows

#### Fix Vim xClip
Download vcxsrv
Run installer using default options
Run vcxsrv using "xlaunch" (search in the start menu)
Add export DISPLAY=localhost:0.0 to your wsl bashrc

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



