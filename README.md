# ws_playbook
Ansible playbook to confire my dev work station. 
Run it with `ansible-playbook local.yml -K` and enter the WSL sudo password.


# Manual Steps on Windows

#### Fix Vim xClip
Download vcxsrv
Run installer using default options
Run vcxsrv using "xlaunch" (search in the start menu)
Add export DISPLAY=localhost:0.0 to your wsl bashrc
