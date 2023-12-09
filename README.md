# geoSCOUT
Scripts related to geoSCOUT.

## geoSCOUT 9.0 launcher

### **This has only been tested with the network install version of geoSCOUT**

This is a script to run the geoSCOUT launcher upgrade for 9.0 for each system that has an older version of geoSCOUT.

The script does the following:
* checks if geoSCOUT is installed and aborts if not found
* checks if the geoSCOUT launcher is version 9 if it isn't it runs the Setup_geoSCOUTLauncher.exe silently to upgrade the geoSCOUT launcher.

To make this script work you will need to do the following:
* upgrade your geoSCOUT network install to 9.0 (follow the normal geoLOGIC steps)
* Copy the updated Setup_geoSCOUTLauncher.exe
* host the Setup_geoSCOUTLauncher.exe somewhere where you can download it and update the script `$DLURL` to reflect the location.
* run the script as admin or run as system if using other script deployment tools

[More detailed documentation](https://thedxt.ca/2023/12/geoscout-9-0-launcher-upgrade/)

### known issues

If geoSCOUT is not found on a system you may get an error of `Resolve-Path : Cannot find path 'C:\Program Files (x86)\geoSCOUT\geoSCOUT.exe' because it does not exist.` this can be ignored as the script aborts if geoSCOUT is not found

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
* host the zip file somewhere where you can download it and update the script `$GeoDL` to reflect the location.
* run the script as admin or run as system if using other script deployment tools

### known issues

If geoSCOUT is not found on a system you may get an error of `Resolve-Path : Cannot find path 'C:\Program Files (x86)\geoSCOUT\geoSCOUT.exe' because it does not exist.` this can be ignored as the script aborts if geoSCOUT is not found

## geoSCOUT published

### **This has only been tested with the network install version of geoSCOUT**

The script will check if the user has the geoLOGIC systems app data folder if they don't it will run the geoSCOUT non admin installer silently then run the geoSCOUT exe. If the user already has the geoLOGIC systems app data folder it will run the geoSCOUT exe normally.

The script does the following:
* checks if the user has the geoLOGIC systems app data folder
* runs the geoSCOUT non admin install silently if the user does not have the geoLOGIC systems app data folder and then runs geoSCOUT normally
* runs geoSCOUT normally if the user already has the geoLOGIC systems app data folder
* will write output to confirm the steps of the script

To make this script work you will need to do the following:
* run the geoSCOUT admin install at least once on the published session host as this creates the geoSCOUT exe in program files.
* edit the geoSCOUT Build non Admin location in the script to match your setup

Optional Tweaks
* comment out the `Write-Host` lines to make it fully silent
* you can make the PowerShell script an exe using tools like [PS2EXE](https://github.com/MScholtes/PS2EXE)

### known issues
* the pin to task bar screen will always show up unless the user manually selects don't remind me
* Tools like [PS2EXE](https://github.com/MScholtes/PS2EXE) may cause false positives in your EDR or AntiVirus you may need to add the hash of your exe to the allow list
