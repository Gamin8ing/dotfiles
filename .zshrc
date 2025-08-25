# StarShip Prompt (again lol)
# a lightweight prompt
eval "$(starship init zsh)"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gamin8ing/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# --------------- PLUGINS CONFIGS ----------------------
#
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# fzf integration
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

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

# ------------------ GIT SSH AGENT ----------------------

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
