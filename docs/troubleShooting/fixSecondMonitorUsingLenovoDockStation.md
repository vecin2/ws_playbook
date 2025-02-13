# Fixing DisplayLink Monitor Detection Issue on Ubuntu

## Problem

When connecting an external monitor through a Lenovo ThinkPad Docking Station, the monitor was not detected on Ubuntu, even though it worked in Windows and when directly connected to the laptop via HDMI. The issue was due to missing DisplayLink drivers and Secure Boot restrictions.

DisplayLink is the technology used by your Lenovo docking station to manage external displays over USB. Since Ubuntu doesn’t include native support for DisplayLink out of the box, you had to install the driver manually.

## Solution

1. Install DisplayLink Repository Keyring

Download and install the Synaptics APT Repository Keyring:
```bash
wget https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb -P ~/Downloads
sudo apt install ~/Downloads/synaptics-repository-keyring.deb
```

2. Update APT and Install DisplayLink Driver

```bash
sudo apt update
sudo apt install displaylink-driver
```

3. Secure Boot and MOK Enrollment

During installation, you will be prompted to enter a password for MOK enrollment.

Restart the laptop.

On boot, you will see the blue MOK Manager screen.

Select "Enroll MOK", then "Continue".

Enter the same password you set earlier.

Select "Reboot".

4. Verify Installation

After rebooting, confirm that the DisplayLink service is running:

systemctl status displaylink-driver

Check if your monitor is now detected:

xrandr --query

Conclusion

By installing the proper drivers and enrolling the MOK key, the external monitor connected via the docking station was successfully detected on Ubuntu.

### After Upgrading Ubuntu

After upgrading Ubuntu, the external monitor stopped working. To resolve this issue, I had to reinstall the DisplayLink driver by running the following command:

`sudo apt install --reinstall displaylink-driver`

That made work the external monitor without even restarting.
