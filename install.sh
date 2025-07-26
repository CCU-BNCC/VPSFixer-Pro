#!/bin/bash
# Installer for VPSFixer-Pro

clear
echo "🔧 Installing dependencies..."
apt update -y && apt upgrade -y
pkg install bash git curl wget figlet -y

echo "✅ Dependencies installed!"
echo "✅ Now you can run: bash vpsfixer.sh"
