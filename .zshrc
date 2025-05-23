HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=10000

setopt inc_append_history
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

if [[ ! -n $TMUX ]]; then
    # get session IDs
    session_ids="$(tmux list-sessions)"

    # create new session if none
    if [[ -z "$session_ids" ]]; then
        tmux new-session
    fi

    # select from ff choices
    #   - Attach existing session
    #   - Create new session
    #   - Start without tmux
    create_new_session="Create new session"
    start_without_tmux="Start without tmux"
    choices="$session_ids\n${create_new_session}:\n${start_without_tmux}:"
    choice="$(echo $choices | fzf | cut -d: -f1)"

    if expr "$choice" : "[0-9]*$" >&/dev/null; then
        # attach existing session
        tmux attach-session -t "$choice"
    elif [[ "$choice" = "${create_new_session}" ]]; then
        # create new session
        tmux new-session
    elif [[ "$choice" = "${start_without_tmux}" ]]; then
        # start without tmux
        :
    fi
fi

alias ls='ls --color=auto -hv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias ll='ls -l'
alias lsa='ls -lA'
alias mvi='mv -i'

autoload -U compinit && compinit

eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
