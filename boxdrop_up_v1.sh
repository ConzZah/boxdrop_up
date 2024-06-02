#!/usr/bin/env bash
clear
  #========================================
  # Project: BOXDROP_UP_v1
  # Author:  ConzZah / ©️ 2024
  # Last Modification: 02.06.2024 / 15:12
  #========================================
# boxdrop_v1
function boxdrop_v1 {
echo "BOXDROP_UPLOADER_v1"; echo ""; echo ""
echo "PASTE FILEPATH"
read fpath
echo "PASTE FILENAME"
read fname
echo ""
# fetch new access_token and write it to raw_access_token.txt
echo "[ ~~~ REFRESHING ACCESS_TOKEN.. ~~~ ]"
curl -s https://api.dropbox.com/oauth2/token -d refresh_token="$refresh_token" -d grant_type=refresh_token -d client_id="$app_key" -d client_secret="$app_secret" > raw_access_token.txt
# sed
sed -i 's/"//g' raw_access_token.txt
sed -i 's/,//g' raw_access_token.txt
sed -i 's/{//g' raw_access_token.txt
sed -i 's/}//g' raw_access_token.txt
sed -i 's/://g' raw_access_token.txt
sed -i 's/ token_type bearer expires_in 14400//g' raw_access_token.txt
sed -i 's/access_token //g' raw_access_token.txt
access_token=$(<raw_access_token.txt) #load access_token
rm raw_access_token.txt
# actual upload
echo "[ ~~~ UPLOADING "$fname" PLEASE WAIT ~~~ ]"; echo ""; echo ""
cd "$fpath"
curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer $access_token" \
    --header "Dropbox-API-Arg: {\"path\": \"/"$fname"\", \"mode\": \"add\", \"strict_conflict\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @"$fname"
echo ""; echo ""; echo "[ ~~~~ UPLOAD DONE ~~~~ ]"; echo ""; echo "[ ~~~ PRESS ANY KEY TO EXIT ~~~ ]"; read -n 1 -s; exit
}
# final_checks
function final_checks {
# checking if "refresh_token.txt" exist, if not, run initial_setup
if [ ! -f ~/boxdrop_config/refresh_token.txt ]; then echo "NO CONFIG FILES FOUND, STARTING INITIAL SETUP."; echo ""; mkdir -p ~/boxdrop_config; cd ~/boxdrop_config; initial_setup; fi
# loading in config files
cd ~/boxdrop_config
app_key=$(<app_key.txt)
app_secret=$(<app_secret.txt)
refresh_token=$(<refresh_token.txt)
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
### LAUNCH ###
final_checks; boxdrop_v1