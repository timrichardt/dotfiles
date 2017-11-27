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

# Go
GOPATH=$HOME/.go

PATH=$PATH:$HOME/bin:$HOME/.cargo/bin:§HOME/.go/bin

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

# vlc screen sharing for Hangouts

alias sharevlc='vlc \
    --no-video-deco \
    --no-embedded-video \
    --screen-fps=20 \
    --screen-top=32 \
    --screen-left=0 \
    --screen-width=1920 \
    --screen-height=1000 \
    screen://'
