#!/bin/bash

# VPSFixer-Pro Main Script
# Made by: MD Abdullah

# Color codes

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Banner
if [ -f "banner.txt" ]; then
    cat banner.txt
else
    echo "VPSFixer-Pro"
fi

fix_apt() {
    echo -e "${YELLOW}🔧 Fixing APT sources and updating packages...${NC}"

    # Termux compatible sources.list path
    if [ -f "$PREFIX/etc/apt/sources.list" ]; then
        cp "$PREFIX/etc/apt/sources.list" "$PREFIX/etc/apt/sources.list.bak"
        echo "deb https://packages.termux.org/apt/termux-main stable main" > "$PREFIX/etc/apt/sources.list"
        apt update && apt upgrade -y
    else
        echo -e "${RED}⚠️  sources.list not found, skipping sources fix.${NC}"
        apt update && apt upgrade -y
    fi

    echo -e "${GREEN}✅ APT fixed and updated successfully.${NC}"
}

fix_hostname() {
    echo -e "${YELLOW}🔧 Fixing hostname and hosts file...${NC}"
    echo -e "${RED}⚠️ Cannot change hostname/hosts in Termux (read-only filesystem). Skipping.${NC}"
}

clean_up() {
    echo -e "${YELLOW}🧹 Cleaning temporary files...${NC}"
    apt autoremove -y
    apt autoclean
    echo -e "${GREEN}✅ System cleaned.${NC}"
}

restart_network() {
    echo -e "${YELLOW}🔁 Restarting network services...${NC}"
    echo -e "${RED}⚠️ Termux does not support restarting network services via 'service' or 'systemctl'. Skipping.${NC}"
}

main_menu() {
    while true; do
        echo -e "\n${YELLOW}===== VPSFixer-Pro Menu =====${NC}"
        echo -e "${GREEN}1.${NC} Fix APT"
        echo -e "${GREEN}2.${NC} Fix Hostname"
        echo -e "${GREEN}3.${NC} Clean System"
        echo -e "${GREEN}4.${NC} Restart Network"
        echo -e "${GREEN}5.${NC} Exit"
        echo -n -e "${YELLOW}Enter choice [1-5]: ${NC}"
        read choice
        case $choice in
            1) fix_apt ;;
            2) fix_hostname ;;
            3) clean_up ;;
            4) restart_network ;;
            5) echo -e "${GREEN}👋 Thanks for using VPSFixer-Pro.${NC}"; exit 0 ;;
            *) echo -e "${RED}❌ Invalid choice.${NC}" ;;
        esac
    done
}

main_menu
