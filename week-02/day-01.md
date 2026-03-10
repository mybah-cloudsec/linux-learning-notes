# Week 2 — Day 1 : Firewalls & Network Filtering

## What is a Firewall ?

Firewalls are digital sentinels that watch over our systems.
They act as vigilant guardians monitoring every data packet
that enters and exits our network.

Mission : Filter traffic, allow passage only to legitimate
data while blocking threats.

---

## Types of Firewalls

### Hardware Firewall
Physical security solution dedicated to network protection.
Examples : security appliances, autonomous security devices

### Software Firewall
Program running on the operating system.
Examples : firewalld, iptables, ufw

---

## firewalld
Dynamic Linux firewall manager.
Works with : Zones and Services

---

## iptables
Decides for each packet :
- ACCEPT — let it through
- DROP — ignore silently (no response)
- REJECT — block with error message

### Rule syntax
iptables [Action] [Chain] [Criteria] -j [Target]

### View rules
sudo iptables -L -n -v
- -L : list rules
- -n : show ports/IP (no DNS resolution)
- -v : verbose mode

### Manage rules
- iptables -A [CHAIN] : append rule at end
- iptables -I [CHAIN] 1 : insert rule at beginning
- iptables -D [CHAIN] 3 : delete rule number 3
- iptables -F : flush (delete all rules)

### Common iptables rules

Allow a port :
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

Block all other traffic (default policy) :
sudo iptables -P INPUT DROP
(if a packet is not explicitly allowed, it is dropped)

Block a specific IP :
sudo iptables -A INPUT -s 192.168.1.100 -j DROP

Verify open ports :
ss -tulnp | grep PORT
ss -atn | grep PORT

---

## ufw (Uncomplicated Firewall)
Simplified interface on top of iptables/nftables.
Easier to use — recommended for beginners.

### Install
sudo apt-get install ufw

### Enable / Disable
sudo ufw enable
sudo ufw disable

### Check status
ufw status

### Allow ports
sudo ufw allow 80/tcp
sudo ufw allow 22/tcp

### Block an IP
sudo ufw deny from 192.168.1.100

### Rate limiting (brute force protection)
ufw limit ssh/tcp

### Logs
cat /var/log/ufw.log

---

## Key differences

| Tool | Level | Use case |
|------|-------|----------|
| iptables | Low level | Full control, servers |
| ufw | High level | Simple rules, easy syntax |
| firewalld | Dynamic | Zones and services |

---

*What I understood :*
DROP silently ignores the packet — the attacker does not know
if the port exists. REJECT sends an error — the attacker knows
the port is blocked. DROP is better for security.
ufw is iptables with a simpler syntax.

*What was difficult :*
The iptables rule order — rules are read top to bottom,
first match wins. Order matters.

*Tomorrow :* Continue Linux networking or Bash scripting
