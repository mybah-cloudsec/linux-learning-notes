# Linux Security Audit Script

A bash script that performs an automated Linux security audit
and generates a timestamped log report.

## Features
- Checks open ports on the system
- Lists users with sudo privileges
- Detects SUID files (potential privilege escalation)
- Verifies /etc/shadow file permissions (COMPLIANT / DANGEROUS)
- Detects exposed SSH private keys in /home and /root
- Lists all currently running services
- Saves a full report in a .log file
- Sends a system notification when audit is complete

## Requirements
- Linux system
- Must be run as root (sudo)
- notify-send (optional — fallback message if not installed)

## Usage

chmod +x security-audit.sh
sudo ./security-audit.sh

## Output

Generates a log file automatically named :
audit_YYYYMMDD_HH-MM.log

Example : audit_20260311_14-32.log

The report is saved in the same directory as the script.

## Example output

====================================================================
                  LINUX SECURITY SCAN
====================================================================
User: root
Date: Tue Mar 11 14:32:00 2026
----------------------------------------------------------------------------

Analysis of Open Ports
...
Users with sudo privileges
...
Search for SUID files
Number of SUID files: 23
...
Verification of /etc/shadow file permissions
Permission: 640 (COMPLIANT)
...
[+] AUDIT FINISHED !
Report saved : /home/yaya/projets/audit_20260311_14-32.log

## Author
mybah-cloudsec
Aspiring Cloud Security Engineer — Conakry, Guinea
github.com/mybah-cloudsec
