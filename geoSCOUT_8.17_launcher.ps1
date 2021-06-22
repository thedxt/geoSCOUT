# geoSCOUT 8.17 launcher upgrade
# author theDXT

# check if temp exists if not make it

$temp = "temp"

if (-not (Test-Path $Env:SystemDrive\$temp))
{
New-Item -ItemType Directory $Env:SystemDrive\$temp | out-null
}

# url to download the geoSCOUT Launcher upgrade installer
$GeoDL = "CHANGE ME"

# download the file to temp
Invoke-WebRequest -Uri $GeoDL -OutFile "$Env:SystemDrive\$temp\geoscout_8.17_Launch.zip"

# extract files and overwrite if another version happens to be there
Expand-Archive -force "$Env:SystemDrive\$temp\geoscout_8.17_Launch.zip" -DestinationPath $Env:SystemDrive\$temp\geoscout_8.17_Launch

#geoscout values
$geoSCOUT_ProgramFilesx86 = "${env:ProgramFiles(x86)}\geoSCOUT\geoSCOUT.exe"
$geoSCOUT_8_16_hash = "5A8B6CD3F666084755DA0E9B7C685690897D18C6453737C13FB2B67A13C5FEA4"
$geoSCOUT_8_17_hash = "8D725153EF171F01D14465BFB4C5ADFE2FDFE2A8CAC412A7573F3F358AA62ECC"

$get_geoSCOUT_hash = get-filehash $geoSCOUT_ProgramFilesx86 -Algorithm "SHA256"

$upgradeEXE = "$Env:SystemDrive\$temp\geoscout_8.17_Launch\Setup_geoSCOUTLauncher.exe"

#geoSCOUT user shortcut replace function
function set-geoSCOUT_UserShortcuts

{

$geoSCOUT_documents = "\Documents\geoSCOUT"

$geoSCOUT_Desktop = "\Desktop"

# get the users minus Default and Administrator and Public
$list_of_users = Get-ChildItem -Path $Env:SystemDrive\Users | Where-Object {($_.Name -notlike "Public") -and ($_.Name -notlike "Administrator") -and ($_.Name -notlike "Default")}

# loop for each user found
Foreach ($user in $list_of_users)

{
# check if the geoSCOUT documents exists already
if (Test-Path "$($user.FullName)$($geoSCOUT_documents)")

# if found copy the file
{
write-host "----------"
write-host "Found $($user.FullName)$($geoSCOUT_documents)"
Write-host "placing the new shortcut on the desktop for $user"
Copy-Item "$Env:SystemDrive\$temp\geoscout_8.17_Launch\geoSCOUT.lnk" -Destination "$($user.FullName)$($geoSCOUT_Desktop)\geoSCOUT.lnk" -force
write-host "----------"
}

else

{
write-host "----------"
write-host "Did not Find $($user.FullName)$($geoSCOUT_documents)"
write-host "skipping $user"
write-host "----------"
}

}

}

#geoSCOUT start menu shortcut replace function
function set-geoSCOUT_StartMenuShortcuts

{

$geoSCOUT_StartMenu = "Microsoft\Windows\Start Menu\Programs\geoSCOUT"

if (Test-Path $Env:ProgramData\$geoSCOUT_StartMenu)
{
write-host "----------"
write-host "Found geoSCOUT Start Menu shortcut"
write-host "copying updated geoSCOUT Start Menu shortcut"
Copy-Item "$Env:SystemDrive\$temp\geoscout_8.17_Launch\geoSCOUT.lnk" -Destination "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\geoSCOUT\geoSCOUT.lnk" -Force
write-host "----------"
}
else
{
write-host "----------"
write-host "geoSCOUT Start Menu shortcut not found"
write-host "creating Start Menu Folder"
New-Item -ItemType Directory $Env:ProgramData\$geoSCOUT_StartMenu | out-null
write-host "copying updated geoSCOUT Start Menu shortcut"
Copy-Item "$Env:SystemDrive\$temp\geoscout_8.17_Launch\geoSCOUT.lnk" -Destination "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\geoSCOUT\geoSCOUT.lnk" -Force
write-host "----------"
}

}

#test if geoSCOUT is instaled
if (Test-Path $geoSCOUT_ProgramFilesx86)

{
write-host "geoSCOUT install is detected"
#Start of installed version detection

#check if version is 8.16
if ($get_geoSCOUT_hash.Hash -eq $geoSCOUT_8_16_hash)
{
write-host "geoSCOUT 8.16 detected"
& $upgradeEXE /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-
set-geoSCOUT_StartMenuShortcuts
set-geoSCOUT_UserShortcuts
}

else

# if 8.16 is not found check if 8.17 is found. If neither is found abort
{
if ($get_geoSCOUT_hash.Hash -eq $geoSCOUT_8_17_hash)
{
write-host "geoSCOUT 8.17 detected"
write-host "geoSCOUT Program Files (x86) replacment step is not needed"
set-geoSCOUT_StartMenuShortcuts
set-geoSCOUT_UserShortcuts
}
else
{
write-host "Unknown geoSCOUT Version Found"
write-host "Aborting"
}
}

#end of installed version detection

}
else

# abort if no geoSCOUT is found
{
write-host "geoSCOUT install is not detected on this system"
write-host "Aborting"
}
