#!/bin/bash

./install.sh



##Adding pluggins###

bash_apps_path=$HOME/dev/bash

mkdir -p $bash_apps_path



#Check make is installed

make -h>/dev/null 2>&1

make_installed=$?



if [ -f "$HOME/.local/bin/bashmarks.sh" ]; then

	echo "Bashmarks already installed"

elif hash make 2>/dev/null; then

	cd $bash_apps_path

	git clone https://github.com/vecin2/bashmarks.git

	cd bashmarks

	make install

	source $HOME/.local/bin/bashmarks.sh

else

	echo "Bashmark cannot be installed because 'make' is not installed."

fi



#install solarized



#base 16

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell



#Update vim version(if version is 'Small Version without GUI')

sudo apt-get install vim-gui-common

sudo apt-get install vim-runtime



#vim vundle

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#you complete me

sudo apt install build-essential cmake python3-dev



#tmux and tmuxinator

sudo apt-get install tmux

sudo apt-get install tmuxinator



#fzf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install



#utils

sudo apt-get install xclip

#ack

sudo apt-get install ack



#python

sudo apt install python-pip

sudo apt install python3

pip3 install virtualenv

pip3 install virtualwrapper
