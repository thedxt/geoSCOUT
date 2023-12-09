# geoSCOUT 9 launcher upgrade
# author theDXT

# url to download the geoSCOUT Launcher upgrade installer
$DLURL = "CHANGE ME"

# the temp folder name for the download and the install to run from
$temp = "temp"

# the nice name of the item you are downloading
$name = "geoSCOUT v9 Launcher"

#last modified date for geoSCOUT Launcher
$mod_date = "2023-11-05"


# function to check if temp exists if not make it

function temp-check{

if (-not (Test-Path $Env:SystemDrive\$temp))
{
New-Item -ItemType Directory $Env:SystemDrive\$temp | out-null
}

}

# function do the download
function Download{

# enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-host "Downloading $name"
temp-check
# Download it
Invoke-WebRequest -Uri $DLURL -OutFile "$Env:SystemDrive\$temp\Setup_geoSCOUT_9_Launcher.exe"
Write-host "$name is downloaded"
}


#geoSCOUT Values
$geoSCOUT_ProgramFilesx86 = "${env:ProgramFiles(x86)}\geoSCOUT\geoSCOUT.exe"

$get_geoSCOUT_date = Get-Item $geoSCOUT_ProgramFilesx86
$upgradeEXE = "$Env:SystemDrive\$temp\Setup_geoSCOUT_9_Launcher.exe"

#test if geoSCOUT is instaled
if (Test-Path $geoSCOUT_ProgramFilesx86)

{
write-host "geoSCOUT install is detected"


#check if the modified date is newer then mod date.

if ($get_geoSCOUT_date.LastWriteTime -gt $mod_date)
{

write-host "geoSCOUT Launcher version 9 detected"
}
Else{
write-host "geoSCOUT Launcher version is NOT 9"

write-host "geoSCOUT 9 launcher upgrade needed"

Download

& $upgradeEXE /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-

write-host "geoSCOUT 9 launcher upgrade is completed"

}
}else{
Write-host "geoSCOUT Install not detected"
Write-host "Aborting"
}
