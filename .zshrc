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

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

alias ls='eza'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias ll='ls -l'
alias lsa='ls -laB'
alias mvi='mv -i'
alias mkgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias upup='sudo pacman -Syyu && mkgrub'
alias fhtc='fht-compositor'
alias rsync='rsync_args'

cpr() {
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
}

mvr() {
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window --remove-source-files "$@"
}

alias ua_drop_caches='sudo paccache -rk3; paru -Sc --aur --noconfirm'
alias ua_update_all='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
    && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
    && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
    && ua_drop_caches'

alias upupup='ua_update_all && upup'

autoload -U compinit && compinit

eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
