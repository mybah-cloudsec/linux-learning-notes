# Week 1 — Practical Lab : SSH with Docker

## Objective
Build a secure SSH connection between Kali (host) and
an Ubuntu container — simulating a real server environment.

## Architecture
Kali (host) /home/yaya/projets/labo-cloud
        |
        | volume mount (-v)
        |
Ubuntu container /home/user/work

## What I practiced
- Create and run an Ubuntu Docker container
- Create a user inside the container
- Configure SSH server with hardening (no password, keys only)
- Generate Ed25519 key pair on Kali
- Deploy public key to container with ssh-copy-id
- Fix UID conflict between host and container
- Fix file ownership with chown -R
- Monitor SSH connections with last, journalctl, ss
- Resolve "Remote Host Identification Has Changed" error

## Commands used

Run container with volume :
sudo docker run -d -it --name NOM \
  -v ~/projets/labo-cloud:/home/user/work \
  ubuntu:latest

Enter container :
docker exec -it NOM bash

Create user :
sudo useradd -m username
sudo passwd username

Fix ownership :
chown -R user:user /home/user

SSH hardening config (/etc/ssh/sshd_config.d/labo.conf) :
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes

Start SSH daemon in Docker :
mkdir -p /var/run/sshd
/usr/sbin/sshd

Deploy key :
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@IP

Monitor connections :
last -a
sudo journalctl -u ssh -f
ss -atnp | grep :22

Fix known_hosts error :
ssh-keygen -R IP

## Key lesson
"If it's not logged, it never happened"
Always document. Always monitor.
