#!/bin/bash
cd ~/tmux_installer
tar -zxf tmux-*.tar.gz
cd tmux-*/
./configure
make && sudo make install
