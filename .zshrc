# ------------------------- GENRAL CONFIG ----------------------
#
# Created by newuser for 5.9
export TZ="Asia/Kolkata"

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

# Installing plugins
# add all plugins here
zinit snippet OMZP::sudo # press <ESC> twice to add/remove `sudo` in your current command
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh # zsh autosuggestions
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # beautiful syntax highlighting for current command
zinit light Aloxaf/fzf-tab # pressing <Tab> for fzf suggestions in current directory

zinit cdreplay -q

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


# ------------- ALIASES -------------------------------
#
alias cd="z" 
# zoxide, easy to use cd

alias lsa="eza -a -l -G --icons=always --group-directories-first --git --no-permissions --no-time -F -X" 
# eza, the better looking ls, looks good

alias lg="lazygit" 
# type lg for lazy git, this saves so much time

# use `c` for clear duh
alias c="clear"

# vim like quitting?
alias :q="exit"

# say 'open' to open things
alias open="wsl-open"

# 'nv' to nvim
alias nv="nvim"

# mkdir and cd in one
mkcdir ()
{
    mkdir -p "$1" &&
       cd "$1"
}

# ------------- END ------------------------------------
# trying vim keybindings in zsh?
bindkey -v
export EDITOR="nvim"
cowsay "\"Do things that make you forget to check your phone.\""

# checking for dotfiles cron job
# Check if dotfiles were successfully pushed checks daily
if grep -i "error" ~/dotfiles/git_cron.log; then
    echo "\e[31mDotfiles not synchronised!\e[0m"  # Red output
elif grep -q "To github.com" ~/dotfiles/git_cron.log; then
    echo "\e[32mDotfiles synced!\e[0m"  # Green output
else
    echo "\e[33mNo new updates to dotfiles\e[0m"  # Yellow output
fi


. "$HOME/.local/bin/env"
