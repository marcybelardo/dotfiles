HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=10000

setopt inc_append_history
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M vicmd "^P" history-beginning-search-backward-end
bindkey -M viins "^P" history-beginning-search-backward-end
bindkey -M vicmd "^N" history-beginning-search-forward-end
bindkey -M viins "^N" history-beginning-search-forward-end

# if [[ ! -n $TMUX ]]; then
#     # get session IDs
#     session_ids="$(tmux list-sessions)"

#     # create new session if none
#     if [[ -z "$session_ids" ]]; then
#         tmux new-session
#     fi

#     # select from ff choices
#     #   - Attach existing session
#     #   - Create new session
#     #   - Start without tmux
#     create_new_session="Create new session"
#     start_without_tmux="Start without tmux"
#     choices="$session_ids\n${create_new_session}:\n${start_without_tmux}:"
#     choice="$(echo $choices | fzf | cut -d: -f1)"

#     if expr "$choice" : "[0-9]*$" >&/dev/null; then
#         # attach existing session
#         tmux attach-session -t "$choice"
#     elif [[ "$choice" = "${create_new_session}" ]]; then
#         # create new session
#         tmux new-session
#     elif [[ "$choice" = "${start_without_tmux}" ]]; then
#         # start without tmux
#         :
#     fi
# fi

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

alias ls='eza'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias ll='ls -l'
alias lsa='ls -laB'
alias mvi='mv -i'

autoload -U compinit && compinit

eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(zellij setup --generate-auto-start zsh)"
