# StarShi Prompt (again lol)
# a lightweight prompt
eval "$(starship init zsh)"
clear
#
# # Lines configured by zsh-newuser-install
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
zstyle ':completion:*' menu select # menu style completion press TAB twice
# End of lines added by compinstall

# for npm 
export PATH=$HOME/.npm-global/bin:$PATH:/home/gamin8ing/.cargo/bin:$HOME/.local/bin/

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

# env=~/.ssh/agent.env
#
# agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
#
# agent_start () {
#     (umask 077; ssh-agent >| "$env")
#     . "$env" >| /dev/null ; }
#
# agent_load_env
#
# # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
# agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
#
# if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
#     agent_start
#     ssh-add
# elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
#     ssh-add
# fi

# unset env
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# source /usr/share/doc/pkgfile/command-not-found.zsh

# --------- STARTUPS -----------

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux -u
fi

# setting manpager as nvim
export MANPAGER='nvim +Man!'

# Set for the LFS
# export LFS=/mnt/wmols
# umask 022

# export http_proxy="http://172.31.2.4:8080"
# export https_proxy="http://172.31.2.4:8080"
# export HTTP_PROXY="http://172.31.2.4:8080"
# export HTTPS_PROXY="http://172.31.2.4:8080"
# export no_proxy="localhost,127.0.0.1"
#
# source ~/.config/environment.d/proxy.conf


# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

# key[Home]="${terminfo[khome]}"
# key[End]="${terminfo[kend]}"
# key[Insert]="${terminfo[kich1]}"
# key[Backspace]="${terminfo[kbs]}"
# key[Delete]="${terminfo[kdch1]}"
# key[Up]="${terminfo[kcuu1]}"
# key[Down]="${terminfo[kcud1]}"
# key[Left]="${terminfo[kcub1]}"
# key[Right]="${terminfo[kcuf1]}"
# key[PageUp]="${terminfo[kpp]}"
# key[PageDown]="${terminfo[knp]}"
# key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
# [[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
# [[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
# [[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
# [[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
# [[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
# [[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
# [[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
# [[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
# [[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
# [[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
# if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
# 	autoload -Uz add-zle-hook-widget
# 	function zle_application_mode_start { echoti smkx }
# 	function zle_application_mode_stop { echoti rmkx }
# 	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
# 	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
# fi

# -----------------------------------------------------------------------------
figlet "Hello World" | lolcat

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# yazi helper function
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
