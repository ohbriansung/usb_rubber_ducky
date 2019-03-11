# USB Rubber Ducky

USB Rubber Ducky is a device looks like a normal thumb drive. However, for computer, it is like a keyboard that could operate the host with ducky script which could be translate into normal keyboard inputs.

## Hardware and tools

### 1. A keyboard adapter

* ie. [USB Rubber Duck](https://shop.hak5.org/products/usb-rubber-ducky-deluxe)

### 2. A microSD card and its adapter

* To store **inject.bin** for sending payloads

### 3. Duck encoder

* To convert ducky script into hex executable files

## Steps to exploit a host

### 1. [Download](https://github.com/hak5darren/USB-Rubber-Ducky) the duck encoder jar file for compiling payloads

```shell
wget -O ~/Downloads/duckencoder.jar https://github.com/hak5darren/USB-Rubber-Ducky/raw/master/duckencoder.jar
```

### 2. Insert the microSD card to your computer with its adapter

### 3. Create a ducky script using any kind of text editor

* Syntax reference [here](https://github.com/hak5darren/USB-Rubber-Ducky/wiki/Duckyscript)

### 4. Compile ducky script into **inject.bin**

* Use duckencoder.jar from *step1* to compile and load the script we just created into microSD card

```shell
java -jar ~/Downloads/duckencoder.jar  -i ~/rubber-ducky/hello-world.txt -o /Volumes/NO\ NAME/inject.bin
```

### 5. Insert the mcroSD card into the keyboard adapter and attack a computer by plugging the keyboard adapter into target

## My Payloads

### 1. [Automatic Mac Password Grabber](./auto_mac_pw_grab/)

## References

\[1\] https://shop.hak5.org/products/usb-rubber-ducky-deluxe

\[2\] https://github.com/hak5darren/USB-Rubber-Ducky/wiki

\[3\] https://blog.hartleybrody.com/rubber-ducky-guide/

\[4\] https://github.com/hak5darren/USB-Rubber-Ducky/wiki/Payloads

\[5\] https://github.com/hak5darren/USB-Rubber-Ducky/wiki/Downloads
