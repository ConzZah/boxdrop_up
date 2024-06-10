#!/usr/bin/env bash
clear
  #========================================
  # Project: BOXDROP_UP.sh [v1.3.2]
  # Author:  ConzZah / ©️ 2024
  # Last Modification: 10.06.2024 / 19:52
  #========================================
# logo
function logo {
clear
echo $c1; echo " BOXDROP UP v1.3.2"; echo $c1
}
# main
function main {
fpath=""
wd=$(pwd)
logo; parse_fpath
}
# parse_fpath
function parse_fpath {
error_msg="ERROR: DIRECTORY IS INVALID, PRESS ENTER TO TRY AGAIN."
list_wd; echo "[ TO USE CURRENT DIR, HIT ENTER ]"; echo ""; echo "INPUT PATH:"; echo ""; read fpath;
if [[ "$fpath" == "" ]]; then fpath=$wd; fi
if [ ! -d "$fpath" ]; then echo "$error_msg"; read -n 1 -s; main; fi
cd "$fpath"; parse_fname
}
# parse_fname
function parse_fname {
error_msg="ERROR: FILENAME IS INVALID, PRESS ENTER TO TRY AGAIN."
logo; list_fpath; echo ""; echo "INPUT FILENAME:"; echo ""; read fname;
if [ ! -f "$fname" ]; then echo "$error_msg"; read -n 1 -s; fname=""; parse_fname; fi
fetch_token
}
# fetch_token
function fetch_token {
# fetch new access_token, run sed & write result to raw_access_token.txt
echo "[ ~~~ GETTING ACCESS_TOKEN.. ~~~ ]"
curl -s https://api.dropbox.com/oauth2/token -d refresh_token="$refresh_token" -d grant_type=refresh_token -d client_id="$app_key" -d client_secret="$app_secret" > raw_access_token.txt 
# ^ ^ ^ gets access_token
sed -i 's/{"access_token": "//g' raw_access_token.txt && sed -i 's/", "token_type": "bearer", "expires_in": 14400}//g' raw_access_token.txt 
# ^ ^ ^ runs sed operations on obtained access_token
access_token=$(<raw_access_token.txt) 
# ^ ^ ^ loads access_token
rm raw_access_token.txt 
# ^ ^ ^ removes current access_token so there are no conflicts 
upload_file
}
# upload_file
function upload_file {
echo ""; echo "[ ~~~ UPLOADING "$fname" PLEASE WAIT ~~~ ]"; echo ""
curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer $access_token" \
    --header "Dropbox-API-Arg: {\"path\": \"/"$fname"\", \"mode\": \"add\", \"strict_conflict\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @"$fname"
echo ""; echo ""; echo "[ ~~~~ UPLOAD DONE ~~~~ ]"; echo ""
ask2repeat_main
}
# ask2repeat_main
function ask2repeat_main {
echo ""; echo "UPLOAD ANOTHER FILE?"; echo ""
echo "Y) YES"
echo "Q) NO (EXIT)"
read ask2repeat_main
case $ask2repeat_main in
	y) clear; main;;
	Y) clear; main;;
	q) echo ""; echo "PRESS ANY KEY TO EXIT"; read -n 1 -s; exit;;
	Q) echo ""; echo "PRESS ANY KEY TO EXIT"; read -n 1 -s; exit;;
	*) clear; ask2repeat_main
esac
}
# initial_setup
function initial_setup {
echo ""; echo "1) INPUT DROPBOX APP KEY"; echo ""; read app_key
echo ""; echo "2) INPUT DROPBOX APP SECRET KEY"; echo ""; read app_secret
echo ""; echo "3) AUTHORIZE YOUR APP AND COPY & PASTE THE GENERATED CODE."; echo ""
echo ""; echo "https://www.dropbox.com/oauth2/authorize?token_access_type=offline&response_type=code&client_id=$app_key"; echo ""; echo ""
echo ""; echo "4) INPUT ACCESS CODE"; echo ""; read auth_code
curl https://api.dropbox.com/oauth2/token \
    -d code=$auth_code \
    -d grant_type=authorization_code \
    -d client_id=$app_key \
    -d client_secret=$app_secret > _raw_refresh_token.txt
fold -s _raw_refresh_token.txt > __raw_refresh_token.txt
sed '1d;2d;3d;4d;6d;7d;' __raw_refresh_token.txt > raw_refresh_token.txt
sed -i 's/"//g' raw_refresh_token.txt
sed -i 's/, scope: //g' raw_refresh_token.txt
echo "$app_key" > app_key.txt
echo "$app_secret" > app_secret.txt
mv raw_refresh_token.txt refresh_token.txt
rm _raw_refresh_token.txt; rm __raw_refresh_token.txt
echo ""; echo "SETUP DONE!"; echo "PRESS ANY KEY TO LAUNCH BOXDROP"; read -n 1 -s; clear; final_checks
}
# list_wd <-- lists current working dir, by default /home/$USER
function list_wd {
echo ""; echo "CURRENT DIRECTORY: $wd"; echo "$c1$c1"; ls|cat; echo "$c1$c1"; echo ""
}
# list_fpath
function list_fpath {
echo ""; echo "LISTING DIRECTORY: $fpath"; echo $c1$c1; ls|cat; echo $c1$c1
}
# final_checks
function final_checks {
# checks if "refresh_token.txt" exist, if not, runs initial_setup
if [ ! -f ~/boxdrop_config/refresh_token.txt ]; then echo "NO CONFIG FILES FOUND, STARTING INITIAL SETUP."; echo ""; mkdir -p ~/boxdrop_config; cd ~/boxdrop_config; initial_setup; fi
# loads config files
cd ~/boxdrop_config
app_key=$(<app_key.txt)
app_secret=$(<app_secret.txt)
refresh_token=$(<refresh_token.txt)
# cosmetics
c1="===================="
cd /home/$USER # <-- standard start dir
}
### LAUNCH ###
final_checks
main
