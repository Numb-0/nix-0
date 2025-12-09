### Check how much Mem is ags or any program taking
`ps aux | grep -i ags | awk '{sum+=$6} END {print sum/1024 " MB"}'`

### Font Family check
`fc-list : family | grep -i "<name>"`
`fc-cache -f or r`

### Udiskie Mount and Umount
after running `udiskie` in hyprland startup you can remove mounted usbs using `udiskie-umount /dev/sda1` (example) then unplug the device 

### List folder and sizes 
du -h --max-depth=1 | sort -h

### scp and remote ssh connection
if the target server/computer has ssh server running you can connect
```
ssh <hostname>@<ip_address>
es: ssh username@192.168.1.45
```
to get the ip you can run `hostname -I` or `ip a`
if you want to copy a file via ssh
```
scp <file_to_copy> <hostname>@<ip_address>:/<path_to_folder>
```
you can use the `-r` recursive flag if you have more folders to copy
you can also save your authentication key generate by `ssh-keygen` to remember your authentication
```
ssh-copy-id username@192.168.1.45
```
fn + esc on ansi us 60% does backtick
