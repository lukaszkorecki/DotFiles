# If not running interactively, don't do anything
[ -z "$PS1" ] && return
if [[ -r ~/.private/env.sh ]] ; then
  source ~/.private/env.sh
fi

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

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls --color -alF'
alias la='ls --color -A'
alias l='ls --color -CF'
alias history='fc -l 1'
alias b=bundle
alias be='bundle exec '
alias r='rails' # sigh
alias s='bundle exec rspec -f n'
alias rs='bundle exec rspec spec -f n -c'
alias ffs='bundle exec rspec -f n 2>/dev/null'
alias rightsplit='tmux splitw -h -p 33 -c $(pwd) '

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

# print given color, need reset after that!
function Color() {
  echo "\[$(tput setaf $1)\]"
}
function ResetColor() {
  echo "\[$(tput sgr0)\]"
}

function thePrompt() {
local reset=$(ResetColor)

  local currentDir="$(Color 5)\W$reset"
  local currentBranch="$(Color 4)$(git cb)$reset"
  local sigil="$(Color 1)➜$reset"
  echo "$currentDir $currentBranch $sigil "
 }
 # prompt command gets called before any other command
 # so this refreshes the git branch and other dynamic stuff
 PROMPT_COMMAND='PS1="$(thePrompt)"'
