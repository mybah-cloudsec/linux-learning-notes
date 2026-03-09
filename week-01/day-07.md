# Day 7 — SSH Configuration & Secure Remote Access

## What is SSH ?
SSH (Secure Shell) allows establishing secure encrypted connections
to distant servers.

---

## Basic Connection

Connect with password :
$ ssh user@IP -p Port

---

## Public Key Authentication

### Secure key types
1. Ed25519 (recommended — more secure and faster)
2. RSA (older but still widely used)

### Generate a key pair
$ ssh-keygen -t ed25519 -C "comment" -N ""
- -t ed25519 : key type
- -C "comment" : label (usually your email)
- -N "" : no passphrase

### Copy public key to server
$ ssh-copy-id -i ~/.ssh/id_ed25519.pub user@IP -p port

---

## SSH Daemon (sshd)

sshd is the SSH server daemon.

- enable : starts automatically at every boot (recommended for servers)
- start : you activate it manually right now (for admin use)

---

## SSH Server Configuration

Main config file : /etc/ssh/sshd_config
Best practice : /etc/ssh/sshd_config.d/ (drop-in config files)

### Security settings (critical)
PermitRootLogin no
PubkeyAuthentication yes

---

## SSH Client Configuration (~/.ssh/config)

Using wildcards (*) in ~/.ssh/config allows specifying
parameters globally.

### Example config block
Host *
    Compression yes          # faster connection
    ServerAliveInterval 60   # send message to server every 60s to maintain connection
    ForwardX11 no            # X11 forwarding disabled

### Wildcard tokens
- * : matches any host
  Example : Host *.example.com
- ? : matches exactly one character
  Example : Host ?.example.com
- ! : negation — allows exclusion
  Example : Host !serveursensible.example.com

---

## Remote Commands via SSH

Execute a command directly on a remote server :
$ ssh user@IP "cd /var/www && ls"

### Benefits of remote commands
- Automation : execute commands as soon as connection is established
- Time saving
- Personalisation

### Config for remote commands (~/.ssh/config)
Host *
    RemoteCommand cd /var/www && ls

---

## How SSH Client Reads Config

SSH client reads ~/.ssh/config sequentially, looking for matching
Host blocks specified in the command. It then applies the config.

You can combine general parameters and host-specific parameters
(host-specific takes priority).

---

## Correct File Permissions for SSH (CRITICAL)

### Client side
1. chmod 700 ~/.ssh
2. chmod 600 ~/.ssh/id_ed25519 (private key)
3. chmod 644 ~/.ssh/id_ed25519.pub (public key)
4. chmod 600 ~/.ssh/authorized_keys
5. chmod 600 ~/.ssh/config

### Server side
Permissions fichier authorized_keys : 600 ~/.ssh/authorized_keys
/config

---

## Debugging SSH Connections

When something does not work, follow this order :

1. Multiple config — check which config block is being applied
2. Network problems — verify connectivity
3. Authentication issues
4. Remove vague errors

### Common SSH errors

Man in the Middle warning :
WARNING : Remote Host Identification Has Changed
Solutions :
1. Check permissions on authorized_keys file : chmod 600 ~/.ssh/authorized_keys
2. Remove old entry : ~/.ssh / known_hosts

---

## Creating a User via SSH (example workflow)

$ sudo useradd -m -n username
$ sudo adduser username
$ sudo passwd username

---

*What I understood :*
Ed25519 is the recommended key type today — more secure than RSA.
Never allow root login via SSH (PermitRootLogin no). File permissions
on SSH files are critical — wrong permissions will block the connection.
The ~/.ssh/config file allows powerful automation with Host blocks.

*What was difficult :*
Understanding wildcard tokens (* and ?) and negation (!) in
~/.ssh/config — now clear with the examples.

*Tomorrow :* Start Week 2 — Bash scripting fundamentals
