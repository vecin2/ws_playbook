## Manual installed apps

Some apps have not been installed in ansible yet, the idea is to move this into ansible tasks.


### DbBeaver
DBclient to access databases here are the steps:

1. Download and add the GPG key properly:
`wget -O- https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/dbeaver-keyring.gpg`
2. Add the DBeaver repository to the sources list:
`echo "deb [signed-by=/usr/share/keyrings/dbeaver-keyring.gpg] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list`
3. Update the package list and install DBeaver:
`sudo apt update`
`sudo apt install dbeaver-ce`

Alternative: Install via Snap
If the APT method is still causing issues, you can install DBeaver using Snap, which is simpler and doesn't require GPG keys:
`sudo snap install dbeaver-ce`
