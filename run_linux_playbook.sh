export  ANSIBLE_VAULT_PASSWORD_FILE=$HOME/vault_password.txt 
ansible-playbook linux_ws.yml -i inventory.ini
