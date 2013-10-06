# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# disable stupid C-s / C-q stuff
stty -ixon

# Tiny wrappers around tput, used in prompt and messages
Color() {
  echo "$(tput setaf $1)"
}
ResetColor() {
  echo "$(tput sgr0)"
}

# if main ssh key is not loaded - warn about it!
if [[ -z  "$(ssh-add -L | grep id_rsa)" ]] ; then
  echo "$(Color 1)Main private key is not loaded!$(ResetColor)" >&2
fi

export LC_LANG=$LANG

# custom scripts and tools
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=/usr/lib/go/bin:$PATH
export PATH=~/Dropbox/Scripts:$PATH

# go setup
export GOPATH=~/proj
export GOBIN=~/proj/bin
export PATH=$PATH:$GOBIN

# android
export ANDROID_HOME=~/proj/sdk
export PATH=~/proj/sdk/tools:$PATH
export PATH=~/proj/sdk/platform-tools:$PATH

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

extra_files="~/.private/env.sh
~/.rvm/scripts/rvm
~/.DotFiles/xres/init.sh
/usr/share/bash-completion/bash_completion"

for extra in $extra_files ; do
  [[ -r $extra ]] && source $extra
done


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
shopt -s checkwinsize # track terminal window resize
shopt -s globstar     # enable **
shopt -s extglob      # extended globbing capabilities
shopt -s dirspell     # correct typos when tab-completing names
shopt -s autocd       # type 'dir' instead 'cd dir'
shopt -s cdspell      # fix minor typos when cd'ing
shopt -s cmdhist      # preserve new lines in history

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls --color -alF'
alias la='ls --color -Ah'
alias l='ls --color -CF'
alias b=bundle
alias be='b exec '

alias rs='be rspec spec -f p -c'
alias ffs='be rspec -f p 2>/dev/null'
alias rightsplit='tmux splitw -h -p 33  '

export EDITOR=vim

# vless was removed - use view

# edit modified files in vim
# use vim as man viewer
viman() {
env PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nolist nonumber' -c 'map q :q<CR>' \
  -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"" man $*
}


# mutt doesn't like urxvt-* and tmux-* TERMs
Mutt() {
  TERM=screen-256color mutt -e "source ~/.private/mutt_$1"
}


# useful as guard replacement (ish)
# Usage:
#    Loop grunt test:all
# or
#    DELAY=10 Loop grunt test:browser
Loop() {
  [[ -z "$DELAY" ]] && DELAY=7
  echo "Loop time $DELAY sec"

  while true ; do
    $*
    sleep $DELAY
  done
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
  echo "$c\\H$reset $currentDir $branch\n$sigil "
}

# prompt command gets called before any other command
# so this refreshes the git branch and other dynamic stuff
PROMPT_COMMAND='PS1="$(Prompt)"'

# plug-in the history hack
PROMPT_COMMAND="$PROMPT_COMMAND ; _bash_history_sync "
