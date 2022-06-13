# geoSCOUT published
# author theDXT

# Variables

# geoSCOUT APPDATA location
$geoSCOUT_appdata = "$Env:APPDATA\geoLOGIC systems"

# geoSCOUT Build non Admin location
$geoSCOT_nonadmin = "\\GEOSCOUT-SERVER\geoSCOUT\Desktop_Build_NonAdmin_v8.exe"

# local system geoSCOUT exe location
$geoSCOUT_exe = "C:\Program Files (x86)\geoSCOUT\geoSCOUT.exe"

# check if geoSCOUT AppData exist
if (Test-Path $geoSCOUT_appdata)

# if geoSCOUT AppData is found then launch geoSCOUT exe
{
write-host "Found it"
start-Process -Filepath $geoSCOUT_exe
}
else

# if geoSCOUT AppData is not found then run the non admin install then launch geoSCOUT
{
write-host "not found"
start-Process -Filepath $geoSCOT_nonadmin -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART" -WindowStyle Hidden -wait
write-host "Did it"
start-Process -Filepath $geoSCOUT_exe
}
