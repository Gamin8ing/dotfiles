#!/usr/bin/env bash

# Colors and symbols
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
CHECK="✔️"
CROSS="❌"
ARROW="➜"

# Find latest backup
latest_backup=$(ls -td "${HOME}/.dotfiles_backup_"* | head -n1)

if [ -z "$latest_backup" ]; then
    echo -e "${RED}${CROSS} No backups found!${NC}"
    exit 1
fi

# Display backup info
echo -e "${YELLOW}${ARROW} Found backup from: $(date -r "$latest_backup" '+%Y-%m-%d %H:%M:%S')${NC}"
echo -e "Contents:"
tree -L 2 "$latest_backup"

# Confirm restoration
read -rp "$(echo -e "${YELLOW}${ARROW} Restore original configs? [y/N] ${NC}")" confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo -e "${RED}${CROSS} Restoration cancelled${NC}"
    exit 0
fi

# Restore process
echo -e "\n${YELLOW}${ARROW} Restoring original configuration...${NC}"
rsync -vrlh --progress "${latest_backup}/" "${HOME}/" 2>/dev/null

# Restore original shell
if [ -f "${latest_backup}/original_shell" ]; then
    original_shell=$(cat "${latest_backup}/original_shell")
    echo -e "${YELLOW}${ARROW} Restoring original shell: ${original_shell}${NC}"
    chsh -s "$(which "$original_shell")"
fi

# Cleanup backup
echo -e "${YELLOW}${ARROW} Cleaning up...${NC}"
rm -rfv "$latest_backup"

echo -e "\n${GREEN}╔════════════════════════════════════════════════════════╗"
echo "║              System Restoration Complete!           ║"
echo "╠════════════════════════════════════════════════════════╣"
echo "║   ${CHECK} Original configuration restored               ║"
echo "║   ${CHECK} Backup directory removed                     ║"
echo "║                                                        ║"
echo "║   Restart your terminal to apply changes               ║"
echo "╚════════════════════════════════════════════════════════╝${NC}"
