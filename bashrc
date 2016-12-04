# -*- mode: sh -*-
export LANG=en_US.UTF-8
unset LC_ALL ; unset LC_LANG
unset command_not_found_handle

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [[ "$TERM" = "dumb" ]] ; then
    PS1="$ "
    return
fi

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
  echo "!! Main private key is not loaded! !!" >&2
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
export PATH=./node_modules/.bin:$PATH
export PATH=/usr/local/bin:$PATH

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
export HISTCONTROL=ignoreboth
export WORDCHARS=''
shopt -s histappend

shopt -s cdspell

# sync history between different sessions, a bit hacky, wish it worked like
# in ZSH
export HISTSIZE=90000000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignorespace:ignoredups

# load extra shell env files only if they are readable
bashCompletion="/usr/share/bash-completion/bash_completion"
[[ -r $bashCompletion ]] && source $bashCompletion

[[ -r ~/.private/env.sh ]] && source ~/.private/env.sh

# bash completion on OSX (needs brew install bash-completion)
if [[ $(uname) = "Darwin" ]] ; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

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

# Vagrant VM settings
export VM_DEFAULT_MEM=6
export VM_DEFAULT_CPUS=4
export VM_STORAGE_MEM=3
export VM_STORAGE_CPUS=4

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

alias irb=pry

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls --color -alF'
alias la='ls --color -Ah'
alias l='ls --color -CF'

alias b=bundle
alias be='b exec '
alias m='bundle exec dotenv -f .env.test m'
alias frm='bundle exec foreman'
alias psg="ps aux | grep -v grep | grep -E "
alias psgv="ps aux | grep -v grep | grep -Ev "
alias gcd='cd $(git root)'

alias v=vagrant

alias rails-server='be dotenv rails s -b 0.0.0.0'
alias rails-console='be dotenv rails c'
alias rails-test='be dotenv -f .env.test rake test'
alias rails-test-js='be dotenv -f .env.test  rake teaspoon'
alias rails-test-all='rails-test && rails-test-js'
alias rails-migrate='be dotenv rake db:migrate && be dotenv -f .env.test rake db:migrate'
alias rails-rollback='be dotenv rake db:rollback && be dotenv -f .env.test  rake db:rollback'

alias lr='lein run'
alias lt='lein test'

alias go-pj='cd ~/go-src/src/github.com'

# mhmmmmmm
export EDITOR=emacsclient

# general git info
function g() {
  if test -e .git ; then
    filesChanged=$(git s | grep -v '#' | wc -l)
    echo "You're in $(Color 3)$(pwd)$(ResetColor)"
    echo "The branch is: $(Color 5)$(git cb)$(ResetColor)"
    echo "There are $(Color 2)$filesChanged$(ResetColor) changed files"
    git s
  else
    echo "$(Color 5)not in git repo$(ResetColor)"
  fi
}


# plug-in the history hack
PROMPT_COMMAND="_bash_history_sync "

# load default virtualenv and disable PS1 inejction
export VIRTUAL_ENV_DISABLE_PROMPT=1
[[ -r ~/.python/bin/activate ]] && source ~/.python/bin/activate

PS1="[\u@\h \w]$ "
