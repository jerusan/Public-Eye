Program for capturing video for the permanent archive.

To Compile:
Navigate to the directory and use the "make" command to compile.

To Run:
Ncurses must be installed on the machine. To install use the command "sudo apt-get install libncurses-dev".
Navigate to the directory and use the "./xiRecordForArchive 2>error" command to run the program.  The use of 2>error will put the Ximea API error output to a text file named "error".

When prompted for number of the next video, enter the number that should be appended to the next recording i.e. the next number after the current highest video number in the archive.  The program will increment this number automatically if multiple recordings are captured.

If you randomly start recieving missing register errors and it says it is not in "MQ Protocol Mode", then you have to download the XIMEA software package for Windows and use the XiCOP to configure the camera. Change the configuration to use the Ximea API instead of USB3 Vision.

Here is a link to the Windows package:[https://www.ximea.com/support/wiki/apis/XIMEA_Windows_Software_Package]
