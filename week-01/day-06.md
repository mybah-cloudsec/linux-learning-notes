# Day 6 — Linux Network Configuration

## Network Interfaces

Understanding Linux networking means knowing how Linux manages
connectivity.

### Interface naming conventions
- eth0, eth1 : old convention based on hardware detection order
- enp0s3, ens33 : predictable names based on PCI bus (adopted by systemd)
- wlan0, wlp3s0 : wireless interfaces

### View all interfaces
$ ip link show

---

## Network Interface Requirements

To establish a network connection, each interface must be configured
with at minimum :
- An IP address (IPv4 or IPv6)
- A subnet mask
- A gateway to exit the local network
- One or more DNS servers

These elements can be defined manually (static IP) or retrieved
automatically via DHCP.

---

## IPv4 vs IPv6

### IP Configuration : Static vs DHCP
- Static IP : used for servers, SSH (distant access), DNS, databases
- DHCP : used for laptops, VMs (VMware), dynamic environments

---

## Network Configuration Tools in Linux

3 tools commonly encountered :

### 1 — systemd-networkd
- Minimalist and server-friendly
- Part of systemd — allows lightweight and declarative config
- Config files location : /etc/systemd/network/
  - .network files — describe network interfaces
  - .netdev files — describe virtual interfaces
- Activate : systemctl enable --now systemd-networkd

### 2 — Netplan
- Used on Ubuntu
- YAML-based configuration

### 3 — Network Manager
- Designed for mobility, dynamic connections and graphical environments
- Commands :
  - nmcli device show — show all network devices details
  - nmtui — text user interface for network config

---

## Useful Network Commands

### View gateway
$ ip route | grep default

### Force DHCP renewal
$ sudo dhclient -v wlan0

### Observe DHCP traffic
$ sudo tcpdump -ni eth0 port 67 or port 68

---

*What I understood :*
Linux has 3 main tools to manage network config. systemd-networkd
is the most server-oriented and lightweight. Each interface needs
minimum 4 things : IP, mask, gateway, DNS. DHCP gives these
automatically, static config sets them manually.

*What was difficult :*
The difference between systemd-networkd and NetworkManager —
now clear : networkd = servers/minimal, NetworkManager = desktops/mobility.

*Tomorrow :* Continue Linux networking — ip commands, SSH configuration
