#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##########################
##       exports        ##
##########################

. "$HOME/.cargo/env"
export EDITOR=vim
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
export HISTIGNORE='&:clear:ls:cd:[bf]g:exit:[ t\]*'

shopt -s histappend

HISTSIZE=10000
HISTFILESIZE=20000

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

##########################
##       defaults       ##
##########################

force_color_prompt=yes
set -o vi
shopt -s checkwinsize
shopt -s cdspell
shopt -s dotglob
shopt -s nocaseglob

##########################
##        aliases       ##
##########################

alias ls='eza'
alias grep='grep --color=auto'
alias ip='ip -c=auto'
alias ll='ls -l'
alias lsa='ls -lab'
alias mvi='mv -i'

eval "$(starship init bash)"

# starting tmux
[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }
