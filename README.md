# SimuS - Sapiens Processor Simulator

SimuS is a simulator focused on computer architecture teaching, emulating the architecture of the Sapiens processor. Sapiens is an 8-bit processor archtecture of relative simplicity and its operation is easy to understand. All this simplicity meets the main goal of enabling the student to understand the low level functioning of a computer.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Building From Source

SimuS is supported on Windows, linux and RaspberryPi. For each platform, there will be instructions below.
FPC 3.0.4 and Lazarus 1.8 or greater is needed.

Windows:

1. Access [Lazarus Download](https://www.lazarus-ide.org/index.php?page=downloads)
2. Download and Install Lazarus IDE
3. Clone this repository or download as zip
4. Extract files
5. Open the simus.lpi file with Lazarus
6. Compile and run!

Linux:

1. Download fpc_src, fpc and lazarus for your distro and arch
   * [DEB x86](https://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20i386%20DEB/Lazarus%201.8.2/)
   * [DEB x64](https://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20amd64%20DEB/Lazarus%201.8.2/)
   * [RPM x86](https://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20i386%20RPM/Lazarus%201.8.2/)
   * [RPM x64](https://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20x86_64%20RPM/Lazarus%201.8.2/)
2. After downloading, install them in the following order:
   * fpc_src
   * fpc
   * lazarus-project
3. With the IDE installed, just clone this repository or download the zip.
4. Open the simus.lpi on lazarus
5. Compile and run!

RaspberryPi:

1. Download the [installation script](https://github.com/sysrpl/Codebot.Setup/blob/master/raspberry/install.fpc-3.0.raspberry.sh)
2. Rename the script to setup.sh
2. Open terminal
3. Give Permission, then run the script
```
chmod +x setup.sh
curl -L http://www.getlazarus.org/download/?platform=linux -o setup.sh
./setup.sh
```
4. The script will verify dependencies
5. If any of them is not found, you need to install them manually.
6. After script finishes successfully, clone or download zip from this repository
7. Open simus.lpi with lazarus
8. Compile and run!

### Installing From Binaries

Binaries are available on [Releases](https://github.com/sottam/simus/releases) Section.
1. Download the one that matches your platform.
2. Setup install or unzip the file
3. SimuS is ready for use!

## Built With

* [Lazarus](https://www.lazarus-ide.org/) - IDE used for coding and debugging
* [Free Pascal](https://www.freepascal.org/) - Open source compiler for Pascal and Object Pascal 
* [Firmata](https://github.com/firmata/protocol) - Communication protocol used to code messages to IoT devices
* [Firmata Pascal](https://github.com/sottam/FirmataPascal) - Implementation of Firmata for Pascal
* [LazSerial](https://github.com/JurassicPork/TLazSerial) - Serial Library used to communicate with IoT devices

## Authors

* **Gabriel P. Silva** 
* **José Antonio Borges**
* [**Alonso Matos do Amparo Neto**](https://github.com/sottam)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


