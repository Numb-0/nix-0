# System Utilities

## Process Management

### Check Memory Usage

Check how much memory a program is using (e.g., ags):

```bash
ps aux | grep -i ags | awk '{sum+=$6} END {print sum/1024 " MB"}'
```

## Font Management

### Check Font Family

List fonts by family name:

```bash
fc-list : family | grep -i "<name>"
```

Rebuild font cache:

```bash
fc-cache -f  # or -r
```

## Storage & Mounting

### Udiskie Mount and Umount

After running `udiskie` in Hyprland startup, you can safely unmount USB devices:

```bash
udiskie-umount /dev/sda1
```

Then unplug the device.

### List Folder Sizes

Display folder sizes sorted by size:

```bash
du -h --max-depth=1 | sort -h
```

## SSH & Remote Access

### SSH Connection

Connect to a remote server via SSH:

```bash
ssh <hostname>@<ip_address>
# Example:
ssh username@192.168.1.45
```

Get your IP address:

```bash
hostname -I
# or
ip a
```

### SCP (Secure Copy)

Copy files via SSH:

```bash
scp <file_to_copy> <hostname>@<ip_address>:/<path_to_folder>
```

Copy directories recursively:

```bash
scp -r <directory> <hostname>@<ip_address>:/<path_to_folder>
```

### SSH Key Authentication

Generate and save authentication key for passwordless login:

```bash
ssh-keygen
ssh-copy-id username@192.168.1.45
```

## Wifi

Shows the connected wifi password and generates a qr

```
nmcli device wifi show-password
```

## Keyboard Tips

- **Backtick on 60% ANSI keyboard:** `Fn + Esc`
