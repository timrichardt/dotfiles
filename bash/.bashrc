#!/bin/bash

alias ls='ls --color'
alias l='ls --color --group-directories-first'
alias ll='l -l'
alias la='l -a'
alias lla='ll -a'
alias lal='la -l'
alias lt='ll -t'
alias lat='lla -t'
alias lrt='ll -rt'
alias lart='lla -rt'

alias ..='cd ..'

PATH=$PATH:$HOME/bin

PS1='\u@\h:\w> '


# ssh-agent

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi

if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
