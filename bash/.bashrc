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

PATH=$PATH:$HOME/bin:$HOME/.cargo/bin:$HOME/.go/bin:$HOME/.local/bin

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


export BLOB_STORAGE=:s3
export S3_BUCKET=blobdb
export S3_ACCESS_KEY=developmentaccess
export S3_SECRET_KEY=developmentsecret
export S3_ENDPOINT="http://localhost:8081"
export S3_PATH_STYLE_ACCESS=true
export DATOMIC_CONNECTION_TYPE=:peer
export DATOMIC_PEER_URL="datomic:dev://localhost:4334/hello" #tests
export RSS_LOG_LEVEL=debug
export MBA_NUM_PARALLEL_REQUESTS=2

export CARP_DIR=~/github/Carp

export JAVA_CMD=/usr/bin/java
