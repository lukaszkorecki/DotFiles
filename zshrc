export LANG=en_GB.UTF-8
export ARCHFLAGS="-arch x86_64"

# fix node binaries
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
export NODE_PATH=/usr/local/lib/jsctags:$NODE_PATH

# GOLANG
export GOPATH=/usr/local/go/bin


if [[ -d /usr/local/Cellar/android-sdk/r20.0.1 ]]; then
  export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/r20.0.1
fi

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
# add npm "binaries"
export PATH=/usr/local/share/npm/bin:$PATH
# add python binaries
export PATH=/usr/local/share/python:$PATH

# add racket bins to path if racket installation exists
if [[ -d /Applications/Racket\ 5.3/bin/ ]]; then
  export PATH=/Applications/Racket\ 5.3/bin:$PATH
fi

# custom scripts and tools
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=~/Dropbox/Scripts:$PATH

# hmmmmm
export PATH=/usr/local/mysql/bin:$PATH
# this is here for a reason! Mysql2 gem will
# fail to initialize because binary lib is not being found
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# Aliases

alias history='fc -l 1'
alias b=bundle
alias be='bundle exec '
alias r='rails' # sigh
alias rs='bundle exec rspec spec -f n -c'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc'


setopt prompt_subst

export LSCOLORS="Gxfxcxdxbxegedabagacad"

export WORDCHARS=''

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Key key bindings
bindkey -e # emacs-style, vi-style doesn't feel natural in command line
bindkey '\C-p' up-line-or-search
bindkey '\C-n' down-line-or-search

# autocompletion
autoload -U compinit
compinit
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
setopt completealiases
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
      'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:tmux:*:subcommands' mode 'commands'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*:processes' command "ps x"

# Edit command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x' edit-command-line

bindkey '\C-a' beginning-of-line
bindkey '\C-e' end-of-line
bindkey '\C-f' forward-word
bindkey '\C-b' backward-word

bindkey '^r' history-incremental-search-backward


# Completion
zmodload -i zsh/complist
# unsetopt menu_complete   # do not autoselect the first completion entry
# unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end


# correction
setopt correct_all

# handy ps wrapper
function Psgr(){
  ps aux | egrep $1 | grep -v grep
}

# work out which ls version we're dealing with
# and export correct color settings
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
# show only directories, ordered by modification date, latest at the bottom
alias lo='ls -ltrd */'

# fix ack-grep binary on linux
if  [[ -e /usr/bin/ack-grep ]]; then
  alias ack='ack-grep'
fi

# VIM stuff---------------------------------------------------------------------
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


# utilities---------------------------------------------------------------------
function EditHost() {
  sudo vim /etc/hosts
  dscacheutil -flushcache
}

function grep-files() {
  echo "searching everywhere! Add file ext to limit the scope"
  for f in ls ./*$2; do ; egrep -nHr --color $1 $f; done
}

function KillMatching() {
  ps aux | egrep $1 | egrep -v "grep|tmux" | awk '{ print $2 } ' | xargs kill -9
}

function run-every-5-sec() {
while true
do
  $*
  sleep 5
done

}

# Convinient wrappers----------------------------------------------------------
function Mutt() {
  TERM=screen-256color mutt -e "source ~/.private/mutt_$1"
}

function Agent(){
  # ssh agent stuff
  eval `ssh-agent`
  ssh-add ~/.ssh/id_rsa
}
function using_gcc() {
  env CC="/usr/bin/gcc-4.2" ARCHFLAGS="-arch x86_32" ARCHS="x86_32" $*
}

# cdd - descend x directories down
# example
#   $ pwd # => /lol/wut/bro/is/this/wut
# then:
#   $ cdd 3
# and youre in:
#   $ /lol/wut/bro/
function cdd() {
  local b="" ; for i in $(seq $1) ; do b+="../" ; done ;
  cd $b
}

# re-run a command if it fails
function with_backoff {
  local max_attempts=${ATTEMPTS-5}
  local timeout=${TIMEOUT-1}
  local attempt=0
  local exitCode=0

  while [[ $attempt < $max_attempts ]]
  do
    set +e
    "$@"
    exitCode=$?
    set -e

    if [[ $exitCode == 0 ]]
    then
      break
    fi

    echo "Failure! Retrying in $timeout.." 1>&2
    sleep $timeout
    attempt=$(( attempt + 1 ))
    timeout=$(( timeout * 2 ))
  done

  if [[ $exitCode != 0 ]]
  then
    echo "You've failed me for the last time! ($@)" 1>&2
  fi
}

export GITHUB_TOKEN=`git config --global --get github.token`
export GITHUB_USER=`git config --global --get github.user`

# GREP--------------------------------------------------------------------------
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# make less suck less-----------------------------------------------------------
export LESS="-RSM~gIsw"

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

# Prompt settings---------------------------------------------------------------
setopt prompt_subst
autoload -U colors && colors

local sigil='%{$fg[red]%}➜%{$reset_color%}'
local host='%{$fg[blue]%}%m%{$reset_color%}'
# git cb is defined in .gitconfig!
local git_branch='%{$fg[green]%}$(git cb)%{$reset_color%}'
local c_path='%{$fg[yellow]%}%~%{$reset_color%}'
PROMPT="${host} ${sigil} "
RPROMPT="${git_branch} ${c_path}"

source ~/.DotFiles/zsh/highlight/zsh-syntax-highlighting.zsh

# extra pre-machine settings
if [[ -f ~/zshrc.local ]]; then
  source ~/zshrc.local
fi
