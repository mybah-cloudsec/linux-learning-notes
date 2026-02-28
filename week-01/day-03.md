# Day 3 — User Management & File Permissions

## User Management

User and group management in Linux is essential for controlling access
to system resources and organizing the rights of each user.

Each user is identified by :
- A unique login name
- A UID (User ID) — number automatically assigned at account creation
- Users are organized into groups identified by a GID (Group ID)

### Types of users
- root : UID = 0 (full power)
- System accounts : UID < 1000 (services, daemons)
- Standard users : UID >= 1000 (real humans)

---

### Key files
- /etc/passwd — login, UID, GID, home directory, shell
- /etc/shadow — encrypted passwords
- /etc/group — group name, GID, members
- /etc/gshadow — sensitive group information

### Read user info
- List users : cut -d: -f1 /etc/passwd
- List groups : cut -d: -f1 /etc/group
- See user details : getent passwd username
- See user groups : groups username

---

### Create and manage users

Create a user :
sudo useradd -m username
(-m creates the home directory at /home/username)

Create with custom options :
sudo useradd -m -s /bin/bash -g users -u 1050 username
- /bin/bash = default shell
- -g users = primary group
- -u 1050 = custom UID

Set a password :
sudo passwd username

Verify creation :
getent passwd username
ls -ld /home/username

Modify a user :
- Rename : sudo usermod -l newname oldname
- Change home : sudo usermod -d /home/newname -m oldname
- Change shell : sudo usermod -s /bin/bash username
- Change UID : sudo usermod -u 1100 username

Delete a user :
- Keep files : sudo userdel username
- Delete with home : sudo userdel -r username
- Find leftover files : find / -user username

---

### Create and manage groups

Create a group :
sudo groupadd developers

Add user to group :
- sudo usermod -aG group user (-a = append, -G = secondary groups)
- sudo usermod -g group user (change primary group)

Remove user from group :
sudo gpasswd -d user group

Delete a group :
sudo groupdel group (only deletes group, not users)

---

### Lock and unlock accounts

Lock (adds ! before password — only root can access) :
sudo passwd -l username

Unlock :
sudo passwd -u username

Lock via usermod :
sudo usermod -L username

Unlock via usermod :
sudo usermod -U username

Verify lock status :
sudo grep username /etc/shadow
(! or * in password field = locked)

---

### Best practices
- Use lowercase usernames without accents
- Use consistent naming format
- Group names linked to the activity/role
- NEVER manually edit /etc/passwd or /etc/group
- Delete unused accounts : lastlog
- Generate strong passwords : pwgen -s 12 1
- Force password change at first login : sudo chage -d 0 username

---

## File Permissions

### Three levels of rights
- u (user) — the owner
- g (group) — the group
- o (others) — everyone else

### Three types of rights
- r = read {4}
- w = write {2}
- x = execute {1}

### Modify permissions

Symbolic mode :
chmod u+x script.sh
chmod g-w script.sh

Numeric mode :
chmod 755 script.sh
(7 = rwx for user, 5 = r-x for group, 5 = r-x for others)

Applied to a directory :
- x = enter the directory
- r = list its files
- w = create or delete files inside

Example :
chmod 755 /project

### Modify ownership

Change owner :
sudo chown paul script.sh

Change owner and group :
sudo chown paul:groupname script.sh

Change only group :
sudo chgrp developers script.sh

---

*What I understood :*
Users are identified by UID, groups by GID. Files /etc/passwd and /etc/shadow
must never be edited manually. Permissions work on 3 levels (user/group/others)
with 3 rights (read/write/execute). chmod 755 = rwxr-xr-x.

*What was difficult :*
The difference between -a and -G in usermod — now clear :
-a = append (keep existing groups), -G = list of secondary groups.

*Tomorrow :* Linux networking — ip, ss, netstat, SSH configuration
