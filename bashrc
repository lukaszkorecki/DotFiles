# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export LANG=en_GB.UTF-8
# custom scripts and tools
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=~/Dropbox/Scripts:$PATH

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export LESS="-RSM~gIsw"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# append to the history file, don't overwrite it
HISTCONTROL=ignoreboth
export WORDCHARS=''
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize
shopt -s globstar
shopt -s autocd

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias history='fc -l 1'
alias b=bundle
alias be='bundle exec '
alias r='rails' # sigh
alias s='bundle exec rspec -f n'
alias rs='bundle exec rspec spec -f n -c'

export EDITOR=vim

# make vim a pager
function vless() {
  local less_path=`find $(vim --version | awk ' /fall-back/ { gsub(/\"/,"",$NF); print $NF }'  )/ -name less.sh`
  if [[ -z $less_path ]]; then
    echo 'less.sh not found'
    exit 1
  fi
  $less_path $*
}
alias vl=vless
alias v=vim


# edit modified files in vim
# use vim as man viewer
function viman() {
env PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nolist nonumber' -c 'map q :q<CR>' \
  -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"" man $*
}


function Mutt() {
  TERM=screen-256color mutt -e "source ~/.private/mutt_$1"
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
PS1='\W \e[0,32m$(git cb)\e[m: '
