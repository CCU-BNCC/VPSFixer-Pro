#!/bin/bash

# VPSFixer-Pro Main Script
# Made by: MD Abdullah

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Show banner
if [ -f "banner.txt" ]; then
    cat banner.txt
else
    echo "VPSFixer-Pro"
fi

# Function to fix apt
fix_apt() {
    echo -e "${CYAN}🔧 Fixing APT sources and updating packages...${NC}"
    cp /etc/apt/sources.list /etc/apt/sources.list.bak
    echo "deb http://deb.debian.org/debian stable main contrib non-free" > /etc/apt/sources.list
    apt update && apt upgrade -y
    echo -e "${GREEN}✅ APT fixed and updated successfully.${NC}"
}

# Function to fix hostname
fix_hostname() {
    echo -e "${CYAN}🔧 Fixing hostname and hosts file...${NC}"
    echo "vps-fixer" > /etc/hostname
    echo "127.0.0.1 localhost" > /etc/hosts
    echo -e "${GREEN}✅ Hostname and hosts file fixed.${NC}"
}

# Function to cleanup temp files
clean_up() {
    echo -e "${CYAN}🧹 Cleaning temporary files...${NC}"
    apt autoremove -y
    apt autoclean
    echo -e "${GREEN}✅ System cleaned.${NC}"
}

# Function to restart services
restart_services() {
    echo -e "${CYAN}🔁 Restarting network services...${NC}"
    service networking restart 2>/dev/null || systemctl restart networking 2>/dev/null
    echo -e "${GREEN}✅ Network restarted.${NC}"
}

# Main menu
while true; do
    echo -e "\n${YELLOW}===== VPSFixer-Pro Menu =====${NC}"
    echo -e "${CYAN}1.${NC} Fix APT"
    echo -e "${CYAN}2.${NC} Fix Hostname"
    echo -e "${CYAN}3.${NC} Clean System"
    echo -e "${CYAN}4.${NC} Restart Network"
    echo -e "${CYAN}5.${NC} Exit"
    echo -n -e "${YELLOW}Enter choice [1-5]: ${NC}"
    read choice
    case $choice in
        1) fix_apt ;;
        2) fix_hostname ;;
        3) clean_up ;;
        4) restart_services ;;
        5) echo -e "${GREEN}👋 Thanks for using VPSFixer-Pro.${NC}"; break ;;
        *) echo -e "${RED}❌ Invalid choice.${NC}" ;;
    esac
done
