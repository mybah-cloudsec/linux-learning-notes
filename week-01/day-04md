# Day 4 - Linux File System & Special Permissions

## Linux File System

The file system in Linux is at the heart of how any server or workstation
operates. It enables efficient organisation, storage and management of
system data and resources.

Hierarchical structure : always starts from the root /

---

### Main directories

| Directory | Role |
|-----------|------|
| / | Root directory — starting point of everything |
| /bin | Essential system binaries needed at boot and for system repair |
| /boot | Files needed to boot the system |
| /dev | Peripheral devices (hardware represented as files) |
| /etc | System configuration files |
| /home | Personal directories for standard users |
| /lib | Shared libraries used by programs to access system functions |
| /media | Mounted external peripherals (USB, CD) |
| /mnt | Manual mount points |
| /opt | Optional third-party software and apps not included in the distro |
| /proc | Virtual file system providing real-time info on running processes |
| /root | Root user home directory |
| /run | Runtime data for processes since last boot |
| /sbin | Essential binaries reserved for root |
| /srv | Data for system services |
| /sys | Virtual file system for kernel and hardware info |
| /tmp | Temporary files — generally cleared at boot |
| /usr | System resources — data and programs not needed at boot |
| /var | Variable data (logs, caches, databases) |

### Important log files
- /var/log/ — system logs directory
- /var/log/boot.log — information about the boot process
- /var/log/auth.log or /var/log/secure — records all authentication
  events (successful and failed logins)

---

## Special Permissions

### Sticky Bit (t)
Prevents deletion of files by anyone other than the file owner,
even if others have write permission on the directory.

Common use : /tmp directory
- Only the owner of a file can delete it
- Set with : chmod +t /directory
- Visible as t in ls -la : drwxrwxrwt

### SetGID (s on group)
When activated on a directory, new files created inside inherit
the group of the parent directory instead of the group of the
user who created them.

Useful for : shared team directories
- Set with : chmod g+s /directory
- Visible as s in group position : drwxrwsr-x

### SetUID (s on user)
When activated on an executable file, it runs with the permissions
of the file owner instead of the user who executes it.

Classic example : /usr/bin/passwd (runs as root to modify /etc/shadow)
- Set with : chmod u+s file
- Visible as s in user position : -rwsr-xr-x
- SECURITY RISK : dangerous if set on wrong files

### Find SUID files on the system (security audit)
find / -perm -4000 -type f 2>/dev/null

### Numeric values for special permissions
- SetUID = 4
- SetGID = 2
- Sticky bit = 1
- Example : chmod 4755 file (SetUID + rwxr-xr-x)

---

*What I understood :*
/proc is not a real directory — it is a virtual file system that shows
live process information. /tmp is cleared at boot. Special permissions
(SUID, SGID, Sticky bit) are critical for security — finding unexpected
SUID files is a standard technique in security audits.

*What was difficult :*
Understanding SUID — now clear : the file runs with the owner's
permissions, not the executor's. That is why it is dangerous on
the wrong files.

*Tomorrow :* SSH configuration and network commands
