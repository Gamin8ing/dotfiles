#!/usr/bin/env bash

# Colors and symbols
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'
CHECK="✔️"
CROSS="❌"
ARROW="➜"

# Pretty header with updated formatting
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════╗"
echo "║                Dotfiles Installation                   ║"
echo "║                $(echo -e "${GREEN}🚀 Powered by ZSH/Neovim/WezTerm ${BLUE}")               ║"
echo "╚════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Confirm proceed
read -rp "$(echo -e "${YELLOW}${ARROW} This will modify system configs. Continue? [y/N] ${NC}")" confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo -e "${RED}${CROSS} Installation aborted${NC}"
    exit 1
fi

# Create backup directory
backup_dir="${HOME}/.dotfiles_backup_$(date +%s)"
echo -e "${YELLOW}${CHECK} Creating backup directory: ${backup_dir}${NC}"
mkdir -p "$backup_dir"

# Backup existing configs
backup_files=(
    "${HOME}/.zshrc"
    "${HOME}/.bashrc"
    "${HOME}/.config/nvim"
    "${HOME}/.config/wezterm"
    "${HOME}/.config/starship.toml"
)

echo -e "${YELLOW}${ARROW} Backing up existing configs...${NC}"
for file in "${backup_files[@]}"; do
    if [ -e "$file" ]; then
        mv -v "$file" "$backup_dir/" 2>/dev/null || echo -e "${RED}${CROSS} Failed to backup ${file}${NC}"
    fi
done

# Save original shell
echo "$(basename "$SHELL")" > "${backup_dir}/original_shell"

# Check for zsh installation
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}${CROSS} Zsh not found!${NC}"
    echo -e "Please install zsh first:"
    echo -e "  ${BLUE}https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH${NC}"
    exit 1
else
    echo -e "${GREEN}${CHECK} Zsh found: $(zsh --version | head -n1)${NC}"
fi

# Install Homebrew
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}${ARROW} Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "${GREEN}${CHECK} Homebrew found: $(brew --version | head -n1)${NC}"
fi

# Core packages to install
core_packages=(
    git fzf eza zoxide zsh-autosuggestions 
    zsh-completions zsh-syntax-highlighting 
    fzf-tab bat lazygit neovim
)

# Install packages with check
echo -e "${YELLOW}${ARROW} Installing core packages...${NC}"
for pkg in "${core_packages[@]}"; do
    if brew list --formula | grep -q "^${pkg}\$"; then
        echo -e "${GREEN}${CHECK} ${pkg} already installed${NC}"
    else
        brew install $pkg && echo -e "${GREEN}${CHECK} Installed ${pkg}${NC}"
    fi
done

# Install GCC through Homebrew
if ! command -v gcc-13 &> /dev/null; then
    echo -e "${YELLOW}${ARROW} Installing GCC...${NC}"
    brew install gcc && \
    echo -e "${GREEN}${CHECK} Installed GCC: $(gcc-13 --version | head -n1)${NC}"
else
    echo -e "${GREEN}${CHECK} GCC already installed: $(gcc-13 --version | head -n1)${NC}"
fi

# Development environment checks
echo -e "\n${YELLOW}${ARROW} Development environment verification:${NC}"
! command -v node &> /dev/null && \
echo -e "${RED}${CROSS} Node.js not found! Install with: ${BLUE}brew install node${NC}"

! command -v python3 &> /dev/null && \
echo -e "${RED}${CROSS} Python3 not found! Install with: ${BLUE}brew install python${NC}"

# Copy config files with progress
echo -e "\n${YELLOW}${ARROW} Copying configuration files...${NC}"
rsync -vrlh --progress \
    --exclude=".DS_Store" \
    --exclude=".git" \
    .zshrc .config/ "${HOME}/" 2>/dev/null

# Set default shell to zsh
if [[ "$(basename "$SHELL")" != "zsh" ]]; then
    echo -e "${YELLOW}${ARROW} Changing default shell to zsh...${NC}"
    chsh -s "$(which zsh)"
fi

# Post-install message
echo -e "\n${GREEN}╔════════════════════════════════════════════════════════╗"
echo "║                 Installation Complete!                 ║"
echo "╠════════════════════════════════════════════════════════╣"
echo "║   ${CHECK} Final Steps:                                  ║"
echo "║                                                        ║"
echo "║   1. Open Neovim and run: :MasonInstallAll             ║"
echo "║   2. Restart your terminal session                     ║"
echo "║   3. Run 'zsh' to start using the new configuration    ║"
echo "║                                                        ║"
echo "║   🔧 Missing development tools? See warnings above!    ║"
echo "╚════════════════════════════════════════════════════════╝${NC}"
