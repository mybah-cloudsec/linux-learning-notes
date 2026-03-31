#!/bin/bash

# Color definition for the style

GREEN='\e[1;32m'
RED='\e[1;31m'
BLUE='\e[1;34m'
YELLOW='\e[1;33m'
FAT='\e[1m'
NC='\e[0m' # No Color

# Check permissions
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}${FAT}This script must be run as root${NC}" 
   exit 1
fi

# File name with date and time
FILE_NAME="audit_$(date +%Y%m%d_%H-%M).log"

# Automatic redirection : everything that follows goes to the file AND to the screen

exec > >(tee -a "$FILE_NAME") 2>&1

# The Body of the script

echo -e "${BLUE}====================================================================${NC}"
echo -e "${BLUE}                  LINUX SECURITY SCAN                               ${NC}"
echo -e "${BLUE}====================================================================${NC}"
echo -e "User: ${FAT} $(whoami) ${NC}"
echo -e "Date: $(date)"
echo -e "----------------------------------------------------------------------------\n"

# Session 1 : Check open ports
echo -e "${GREEN}Analysis of Open Ports${NC}"
if command -v ss > /dev/null; then
   ss -tulnp
else 
   netstat -tulnp
fi 
echo -e "\n"

# Session 2 : Check user sudo
echo -e "${GREEN}Users with sudo privileges${NC}"
grep "^sudo" /etc/group
echo -e "\n"

# Session 3: Check sensitives files
echo -e "${YELLOW}Search for SUID files${NC}"
SUID_FILES=$(find / -perm -4000 -type f 2>/dev/null)
COUNT_SUID=$(echo "$SUID_FILES" | wc -l)
echo -e "Number of SUID files: ${FAT}$COUNT_SUID${NC}"
echo -e "$SUID_FILES" | head -n 15
echo -e "...(check the log for the full list)"
echo -e "\n"

echo -e "${YELLOW}Verification of /etc/shadow file permissions${NC}"
PERM=$(stat -c "%a" /etc/shadow)
if [[ "$PERM" -eq 640 ]] || [[ "$PERM" -eq 600 ]] || [[ "$PERM" -eq 0 ]]; then
    echo -e "Permission: $PERM ${GREEN}(COMPLIANT)${NC}"
else
    echo -e "Permission: $PERM ${RED}(DANGEROUS)${NC}"
fi
echo -e "\n"

# Session 4: Check SSH keys
echo -e "${YELLOW}Verification of exposed SSH private keys${NC}"
find /home /root -name "id_*" ! -name "*.pub" 2>/dev/null
echo -e "\n"

# Check Actives Services
echo -e "${GREEN}Check Active Services${NC}"
systemctl list-units --type=service --state=running --no-legend | awk '{printf "%-40s %s\n", $1, $3}'
echo -e "\n"

# Retrieving the full path for the user
REAL_PATH=$(realpath "$FILE_NAME")

echo -e "${BLUE}---------------------------------------------------------------------------${NC}"
echo -e "${GREEN}[+] AUDIT FINISHED ! ${NC}"
echo -e "${GREEN} Report saved : ${NC}${REAL_PATH}"
echo -e "${BLUE}===========================================================================${NC}"

# System Notification
if command -v notify-send > /dev/null; then
    notify-send "Audit Finished" "Report : $FILE_NAME" -i dialog-information
else
    echo -e "${YELLOW}System notification not available (notify-send not found)${NC}"
fi
