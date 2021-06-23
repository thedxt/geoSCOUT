# geoSCOUT
Scripts related to geoSCOUT.

## geoSCOUT 8.17 launcher

### **This has only been tested with the network install version of geoSCOUT**

This is a script to run the geoSCOUT launcher upgrade for 8.17 as per system install rather than a per user install.

The script does the following:
* checks if geoSCOUT is installed abort if not found
* checks if 8.17 is already installed if installed it only updates the shortcuts
* checks if 8.16 is found if found it runs the Setup_geoSCOUTLauncher.exe and updates the shortcuts.
* Aborts if geoSCOUT is not 8.16 or 8.17
* only replaces the user desktop shortcut for users if they have Documents\geoSCOUT (if your setup is diffrent you'll need to tweak that)

To make this script work you will need to do the following:
* upgrade your geoSCOUT network install to 8.17 (follow the normal geoLOGIC steps)
* Copy the updated Setup_geoSCOUTLauncher.exe (should have a modified date of 2021-03-22)
* run the new Setup_geoSCOUTLauncher.exe on a system
* take a copy of one of the updated shortcut files (this happens after you run new Setup_geoSCOUTLauncher.exe)
* make a zip file that has the new Setup_geoSCOUTLauncher.exe and the updated geoSCOUT.lnk shorcut. (all the files need to be in the root of the zip)
* host the zip file somewhere where you can download it and update the script $GeoDL to reflect the location.

### known issues

If geoSCOUT is not found on a system you may get an error of `Resolve-Path : Cannot find path 'C:\Program Files (x86)\geoSCOUT\geoSCOUT.exe' because it does not exist.` this can be ignored as the script aborts if geoSCOUT is not found
