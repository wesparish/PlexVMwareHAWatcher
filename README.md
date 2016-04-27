# PlexVMwareHAWatcher
Tool to watch Plex server status and send VMware HA heartbeats

## Install Instructions
- Configure VMware DRS / HA in vCenter
- Enable application level HA monitoring for your Plex VM
- Download and extract the VMware HA SDK (free)
- (Optional) Update the `LD_LIBRARY_PATH` and `VMW_BINARY` variables in the script
- Add the PlexVMwareHAWatcher.sh script to your Plex VM
- Link the service to init.d
```
ln -s /etc/init.d/PlexVMwareHAWatcher /root/PlexVMwareHAWatcher/PlexVMwareHAWatcher
```
- Enable the service
```
update-rc.d PlexVMwareHAWatcher defaults
```
- Reboot your Plex VM to ensure changes take effect

## Test instructions
- Tail your log file
```
tail -f /var/log/PlexVMwareHAWatcher.sh
```
- Unmount your media storage in another SSH session
```
umount /mnt/plex_media
```
- Expect to see failures in the log and the VM to reboot automatically in 30 seconds
