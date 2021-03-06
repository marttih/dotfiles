# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=8000
export SAVEHIST=4096
export HISTFILE=~/.zhistory

# automatically pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt PUSHD_IGNORE_DUPS
setopt cdablevars

# Try to correct command line spelling
#setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# vi-like keybindings
set -o vi

# python
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi
export PYTHONSTARTUP=~/.pystartup

export PATH=$PATH:${HOME}/bin
export PIP_DOWNLOAD_CACHE=/var/db/pip-cache
