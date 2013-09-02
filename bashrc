# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# disable stupid C-s / C-q stuff
stty -ixon

if [[ -r ~/.private/env.sh ]] ; then
  source ~/.private/env.sh
fi

# we're probably in X
if [[ "$XAUTHORITY" != "" ]] ; then
  # turn off capslock when starting first terminal session
   setxkbmap -option ctrl:nocaps
   xrdb -merge ~/.Xresources
   xrdb -merge ~/.DotFiles/xres/zenburn
fi

export LC_LANG=$LANG

# load RVM if it's present (for old machines only!)
if [[ -r  ~/.rvm/scripts/rvm ]] ; then
  source  ~/.rvm/scripts/rvm
fi

# custom scripts and tools
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=/usr/lib/go/bin:$PATH
export PATH=~/Dropbox/Scripts:$PATH

# go setup
export GOPATH=~/proj
export GOBIN=~/proj/bin
export PATH=$PATH:$GOBIN

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export LESS="-RSM~gIsw"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# append to the history file, don't overwrite it
HISTCONTROL=ignoreboth
export WORDCHARS=''
shopt -s histappend

# sync history between different sessions, a bit hacky, wish it worked like
# in ZSH
HISTSIZE=90000000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

history() {
  _bash_history_sync
  builtin history "$@"
}

# "callback" for use after running a command
_bash_history_sync() {
  builtin history -a
  HISTFILESIZE=$HISTSIZE
  builtin history -c
  builtin history -r
}

# nice things
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd # type 'dir' instead 'cd dir'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls --color -alF'
alias la='ls --color -A'
alias l='ls --color -CF'
alias ls-lah=ll
alias b=bundle
alias be='bundle exec '
alias r='rails' # sigh
alias s='bundle exec rspec -f n'
alias rs='bundle exec rspec spec -f n -c'
alias ffs='bundle exec rspec -f n 2>/dev/null'
alias rightsplit='tmux splitw -h -p 33  '

export EDITOR=vim

# make vim a pager
vless() {
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
viman() {
env PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nolist nonumber' -c 'map q :q<CR>' \
  -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"" man $*
}


Mutt() {
  TERM=screen-256color mutt -e "source ~/.private/mutt_$1"
}


# useful as guard replacement (ish)
# Usage:
#    Loop grunt test:all
# or
#    DELAY=10 Loop grunt test:browser
Loop() {
  if [[ -z "$DELAY" ]] ; then
    DELAY=7
  fi

  echo "Loop time $DELAY sec"

  while true
  do
    $*
    sleep $DELAY
  done
}

# print given color, need reset after that!
Color() {
  echo "\[$(tput setaf $1)\]"
}
ResetColor() {
  echo "\[$(tput sgr0)\]"
}

Prompt() {
  local reset=$(ResetColor)

  local currentDir="$(Color 6)\w$reset"
  local branch=$(git cb)
  if [[ -n "$branch" ]];  then
    branch="$(Color 4)$branch$reset"
  fi
  local sigil="$(Color 1):$reset"
  local c=$(Color 3)
  echo "$c\\H$reset $currentDir $branch$sigil "
}

# prompt command gets called before any other command
# so this refreshes the git branch and other dynamic stuff
PROMPT_COMMAND='PS1="$(Prompt)"'

# plug-in the history hack
PROMPT_COMMAND="$PROMPT_COMMAND ; _bash_history_sync "
