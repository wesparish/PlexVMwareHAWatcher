#!/bin/bash

export LD_LIBRARY_PATH=/root/GuestSDK/lib/lib64/

# Usage: /root/GuestSDK/bin/bin64/vmware-appmonitor {enable | disable | markActive | isEnabled | getAppStatus | postAppState [appStateOk|appStateNeedReset]}
VMW_BINARY=/root/GuestSDK/bin/bin64/vmware-appmonitor

LOG_FILE=${1-/var/log/PlexVMwareHAWatcher.log}
echo "Logging to: $LOG_FILE"
#echo "" > $LOG_FILE

#$VMW_BINARY enable 
while true ; do
  echo "$(date) Checking Plex status" >> $LOG_FILE
  movieId=$(curl 'http://127.0.0.1:32400/library/sections/1/all/' 2> /dev/null | grep -m 1 ratingKey | grep -o '\bratingKey="[^"]*"' | cut -d '"' -f 2)
  
  if [ "$(curl 'http://127.0.0.1:32400/library/metadata/'$movieId'?checkFiles=1' 2> /dev/null | grep -m 1 'Part accessible' | grep -o '\baccessible="[^"]*"' | cut -d '"' -f 2)" == "1" ] ; then
    echo "$(date) Plex status shows UP for movie ID: $movieId" >> $LOG_FILE
    echo "$(date) Sending up status" >> $LOG_FILE
#    $VMW_BINARY markActive
    sleep 15
  else
    echo "$(date) Plex status shows DOWN for movie ID: $movieId" >> $LOG_FILE
    # Sleep 5s on failure to keep trying
    sleep 5
  fi
done
