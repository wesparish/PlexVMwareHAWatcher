# PlexVMwareHAWatcher
Tool to watch Plex server status and send VMware HA heartbeats

## Install Instructions
1. Configure VMware DRS / HA in vCenter
2. Enable application level HA monitoring for your Plex VM
3. Download and extract the VMware HA SDK (free)
4. (Optional) Update the `LD_LIBRARY_PATH` and `VMW_BINARY` variables in the script
5. Add the PlexVMwareHAWatcher.sh script to your Plex VM
6. As a quick "service" install you can add something similar to the following your rc.local
```
cat '/root/PlexVMWareHAWatcher/PlexVMwareHAWatcher.sh >& /var/log/PlexVMwareHAWatcher.sh &' >> /etc/rc.local
```
7. Reboot your Plex VM to ensure changes take effect

## Test instructions
1. Tail your log file
```
tail -f /var/log/PlexVMwareHAWatcher.sh
```

2. Unmount your media storage in another SSH session
```
umount /mnt/plex_media
```
3. Expect to see failures in the log and the VM to reboot automatically in 30 seconds

