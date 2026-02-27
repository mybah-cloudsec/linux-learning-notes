*Topic :* Process Management & Service Management with systemd

---

#### Process Management

*Signals :*
| Signal | Number | Meaning |
|--------|--------|---------|
| SIGTERM | 15 | Please stop gracefully |
| SIGKILL | 9 | Stop immediately, no choice |
| SIGSTOP | 19 | Pause |
| SIGCONT | 18 | Resume work |

*Process priorities : nice and renice (-20 to 19)*
- Higher value = lower priority
- Lower value = higher priority

*Key commands :*
- ps aux — View all running processes
- top — Real-time process monitor
- kill -9 PID — Force kill a process
- lsof -i :80 — See which process uses port 80
- bg — Send process to background
- fg — Bring process to foreground
- jobs — List suspended processes
- strace — Trace system calls

*Important concept :*
- Process = tool (does the work)
- Service = employee (managed by systemd, runs in background)


#### Service Management with systemd

systemd is the first process launched at boot (PID 1). It initializes everything else.

*Boot sequence :* BIOS → GRUB → Kernel → systemd → Session

*Essential systemctl commands :*
- systemctl status nginx — Full status
- systemctl start nginx — Start NOW
- systemctl stop nginx — Stop NOW
- systemctl enable nginx — Start at next boot
- systemctl enable --now nginx — Start now AND at boot
- systemctl disable nginx — Do not start at boot
- systemctl restart nginx — Stop then start
- systemctl reload nginx — Reload config without stopping
- systemctl mask nginx — Completely block a service
- systemctl unmask nginx — Unblock it
- systemctl is-active nginx — Is it running now ?
- systemctl is-enabled nginx — Will it start at boot ?
- systemctl daemon-reload — Reload systemd after changes

*enable vs start :*
- enable = starts at next boot
- start = starts right now
- enable --now = both at once

---

#### Logs with journalctl

- journalctl -u nginx -f — Live logs
- journalctl -u nginx -xeu — Detailed with explanations
- journalctl -u nginx -b — Since last boot
- journalctl -u nginx -n 30 — Last 30 lines
- journalctl -u nginx --since "2026-02-27" — From specific date

*Debug workflow when something breaks :*
1. systemctl status service → Overview
2. journalctl -xeu service → Detailed logs
3. systemctl cat service → Full config file
4. systemctl show service → All effective values

##### NB: nginx = here can be any service
---

#### Creating a Custom Service

Steps :
1. Create file at /etc/systemd/system/my-app.service
2. systemctl daemon-reload
3. systemctl enable --now my-app

Structure of a .service file :
- [Unit] — Metadata and dependencies (Description, After, Requires)
- [Service] — How to run (Type, ExecStart, Restart, User)
- [Install] — When to activate (WantedBy=multi-user.target)


*What I understood :* systemd is the master process PID 1. SIGKILL forces stop, SIGTERM asks politely. journalctl is the central debug tool.
*Tomorrow :* Linux file permissions — chmod, chown, SUID, sticky bit
