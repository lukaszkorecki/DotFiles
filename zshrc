export MODE_INDICATOR="%{$fg_bold[red]%}N%{$fg[red]%}ormal%{$reset_color%}"
export ZSH=$HOME/.oh-my-zsh

export LANG=en_US.UTF-8

export EDITOR='vim'

# over write default mode indicator from vi-mode
export ZSH_THEME="Soliah"

plugins=(vi-mode git rvm ruby)

source $ZSH/oh-my-zsh.sh

# key shortcuts

bindkey '\C-x' edit-command-line

# Tweak the vi mode
# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward

# set up for insert mode too
bindkey -M viins '^P' history-incremental-pattern-search-backward
bindkey -M viins '^N' history-incremental-pattern-search-forward

# Aliases

alias be='bundle exec '
alias gs='git status'
alias gco='git commit'
alias gc='git commit'
alias testenv='RAILS_ENV=test '
alias install_this_mysql_gem='ARCHFLAGS="-arch x86_64" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config '
alias prev='qlmanage -p '

alias ng="~/.nginx/sbin/nginx"
alias bm="bin/msp"


alias vless='/usr/local/share/vim/vim73/macros/less.sh'

if  [[ -e /usr/bin/ack-grep ]]; then
  alias ack='ack-grep'
fi

function current_branch() {}
function any() {
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    echo "any - grep for process(es) by keyword" >&2
    echo "Usage: any " >&2 ; return 1
  else
    ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
  fi
}

function ShowProc() {
  ps aux | grep $1 | grep -v grep
}
function SuperKill() {
  ps aux | grep $1 | grep -v grep | awk {' print $2 '} | xargs kill -9
}


function GemInst() {
  gem install $1 --no-ri --no-rdoc
}

function Growl() {
  growlnotify -n "(s)HELL" -m "$*"
}

function Agent(){
  # ssh agent stuff
  eval `ssh-agent`
  ssh-add ~/.ssh/id_rsa
}
function using_gcc() {
  env CC="/usr/bin/gcc-4.2" ARCHFLAGS="-arch x86_32" ARCHS="x86_32" $*
}

REPORTTIME=5

function viman() {
env PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
      vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
          -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
              -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"" man $*
}

export GITHUB_TOKEN=`git config --global --get github.token`
export GITHUB_USER=`git config --global --get github.user`
export ARCHFLAGS="-arch x86_64"


export GIT_SSL_NO_VERIFY=true

# make less suck less
export LESS="-RSM~gIsw"

export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=~/Dropbox/Scripts:$PATH
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=/opt/PalmSDK/Current/bin/:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

