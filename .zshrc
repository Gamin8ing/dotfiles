
# ------------------------- GENRAL CONFIG ----------------------
#

# brew installation
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# StarShip Prompt (again lol)
# a lightweight prompt
eval "$(starship init zsh)"

# Better zsh history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
HISTDUP=erase
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


# --------------- PLUGINS CONFIGS ----------------------
#
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# fzf integration
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# configuring fzf-tab
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# setting up syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# ------------- ALIASES -------------------------------
#
alias cd="z" 
# zoxide, easy to use cd

alias lsa="eza -a -l -G --icons=always --group-directories-first --git --no-permissions --no-time --no-user -F -X" 
# eza, the better looking ls, looks good

alias lg="lazygit" 
# type lg for lazy git, this saves so much time

# use `c` for clear duh
alias c="clear"

# vim like quitting?
alias :q="exit"

# say 'open' to open things
alias open="xdg-open"

# 'nv' to nvim
alias nv="nvim"

# mkdir and cd in one
mkcdir ()
{
    mkdir -p "$1" &&
       cd "$1"
}

# mux for tmuxinator and tmux
alias mux="tmuxinator"
alias tmux="tmux -u"

# ------------- END ------------------------------------
# trying vim keybindings in zsh?
bindkey -v
export EDITOR="nvim"

# -------------- PROXY SETTING ------------------------
# Load proxy config
CONFIG_FILE="$HOME/.proxy_config"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

# Apply proxy if enabled
if [[ "$is_proxy" == "1" ]]; then

    # Set GNOME proxy settings
    gsettings set org.gnome.system.proxy mode 'manual'
    gsettings set org.gnome.system.proxy.http host "$proxy_ip"
    gsettings set org.gnome.system.proxy.http port 8080
    gsettings set org.gnome.system.proxy.https host "$proxy_ip"
    gsettings set org.gnome.system.proxy.https port 8080

    # Export environment variables
    export http_proxy="http://$proxy_ip:8080"
    export https_proxy="http://$proxy_ip:8080"
    export no_proxy="localhost,127.0.0.1"

    # Optional: Captive portal login
    curl -s -H "Authorization: Basic aWl0MjAyMzA3MDpCaGF2eWFAMjMwNg==" \
      -H "User-Agent: Mozilla/5.0" \
      "http://$ironport.iiita.ac.in/B0001D0000N0000N0000F0000S0000R0004/172.19.6.124/http://fixwifi.it/" > /dev/null

    if [[ $? -ne 0 ]]; then
      echo "\e[31m !!Network booting or Error occurred\e[0m"
    else
      echo "\e[32m[+] Proxy enabled with IP: $proxy_ip\e[0m"
    fi
else
    echo "\e[31m[-] Proxy disabled\e[0m"

    gsettings set org.gnome.system.proxy mode 'none'
    unset http_proxy https_proxy 
fi

export PATH=~/.npm-global/bin:$PATH

# ---------------- STARTUP --------------------------------- #
# tmux at startup
# tmux

eval $(thefuck --alias)
