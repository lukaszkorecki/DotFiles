# -*- mode: sh -*-
export LANG=en_US.UTF-8
unset LC_ALL ; unset LC_LANG
unset command_not_found_handle

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [[ "$TERM" = "dumb" ]] ; then
    PS1="> "
    return
fi
# disable stupid C-s / C-q stuff
stty -ixon

# Tiny wrappers around tput, used in prompt and messages
Color() {
  echo "\[$(tput setaf $1)\]"
}
ResetColor() {
  echo "\[$(tput sgr0)\]"
}

# if main ssh key is not loaded - warn about it!
if [[ -z  "$(ssh-add -L | grep id_rsa)" ]] ; then
  echo "$(Color 1)Main private key is not loaded!$(ResetColor)" >&2
fi

LoadSshKeys() {
  if ssh-add -l 2>&1 | grep 'Could not open a conn' ; then
    echo "> Reactivating ssh-agent"
    eval `ssh-agent`
  fi

  echo "> Adding id_rsa key"
  ssh-add ~/.ssh/id_rsa
}

# custom scripts and tools
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=$HOME/.private/bin:$PATH
export PATH=~/Dropbox/Scripts:$PATH

for dir in ~/.DotFiles/bins/vendor/* ; do
  export PATH=$dir:$PATH
done

# colors in less and ls
export LESS="-rRSM~gIsw"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# go
export GOPATH=~/go-src
export PATH=$PATH:$GOPATH/bin

# append to the history file, don't overwrite it
HISTCONTROL=ignoreboth
export WORDCHARS=''
shopt -s histappend

# sync history between different sessions, a bit hacky, wish it worked like
# in ZSH
HISTSIZE=90000000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

# load extra shell env files only if they are readable
bashCompletion="/usr/share/bash-completion/bash_completion"
[[ -r $bashCompletion ]] && source $bashCompletion

[[ -r ~/.private/env.sh ]] && source ~/.private/env.sh

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
shopt -s extglob      # extended globbing capabilities
shopt -s cdspell      # fix minor typos when cd'ing
shopt -s cmdhist      # preserve new lines in history

# these options are only availabe in Bash4, which is
# not available in OSX
if [[ $BASH_VERSION == 4* ]] ; then
  shopt -s autocd       # type 'dir' instead 'cd dir'
  shopt -s dirspell     # correct typos when tab-completing names
  shopt -s globstar     # enable **
fi

# if neovim is installed - use that
which nvim 2>&1 > /dev/null  && alias vim=nvim

alias irb=pry
alias mssh=mosh
alias :e=vim
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls --color -alF'
alias la='ls --color -Ah'
alias l='ls --color -CF'
alias b=bundle
alias be='b exec '
alias bef='bundle_exec_with_env'
alias tbef='ENV_FILE=.env.test bundle_exec_with_env'
alias m='tbef m'
alias frm='bundle exec foreman'
alias psg="ps aux | grep -v grep | grep -E "
alias psgv="ps aux | grep -v grep | grep -Ev "
alias gcd='cd $(git root)'

alias g=git
alias rs='be rspec spec -f p -c'
alias ffs='be rspec -f p 2>/dev/null'
alias rightsplit='tmux splitw -h -p 33  '
alias v=vagrant
alias gcd='cd $(git root)'

alias rails-server='bef rails s -b 0.0.0.0'
alias rails-console='bef rails c'
alias rails-test='ENV_FILE=.env.test bef rake test'
alias rails-test-js='ENV_FILE=.env.test bef rake teaspoon'
alias rails-test-all='rails-test && rails-test-js'
alias rails-migrate='bef rake db:migrate && ENV_FILE=.env.test bef rake db:migrate'
alias rails-rollback='bef rake db:rollback && ENV_FILE=.env.test bef rake db:rollback'

alias lr='lein run'
alias lt='lein test'

alias go-pj='cd ~/go-src/src/github.com'

# mhmmmmmm
export EDITOR=zile

svim() {
  vim $(find . -type f -and -not -path '**/.git/**' | selecta)
}

# copy/paste stuff
alias cpy='xsel -ib'
alias pst='xsel -ob'

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

  $*
  while sleep $DELAY; do
    $*
  done
}

readonly ____sigil="$(Color 1)λ$(ResetColor)"
readonly ____sep="$(Color 3)|$(ResetColor)"
readonly ____c="$(Color 6):$(ResetColor)"
Prompt() {
  test -e .git && local branch="$____sep $(git cb)"

  echo "$____sigil \W ${branch:-$____sep} $____c "

}


# prompt command gets called before any other command
# so this refreshes the git branch and other dynamic
PROMPT_COMMAND='PS1="$(Prompt)"'

# plug-in the history hack
PROMPT_COMMAND="$PROMPT_COMMAND ; _bash_history_sync "

# load default virtualenv
[[ -r ~/.python/bin/activate ]] && source ~/.python/bin/activate
