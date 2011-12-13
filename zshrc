# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="terminalparty"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rvm ruby)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#
bindkey '\C-x' edit-command-line


# Aliases

# alias vim='/usr/local/Cellar/vim/7.3.333/bin/vim'
alias palm-tunnel='ssh -p 5522 -L 5581:localhost:8080 root@localhost'
alias gs='git status'
alias gco='git commit -m '
alias testenv='RAILS_ENV=test '
alias install_this_mysql_gem='ARCHFLAGS="-arch x86_64" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config '
alias prev='qlmanage -p '

alias tm='tmux -2 -u'
alias ng=~/.nginx/sbin/nginx
function git(){hub "$@"}

alias vitodo='vim ~/Dropbox/todo/todo.txt'
if  [[ -e /usr/bin/ack-grep ]]; then
  alias ack='ack-grep'
fi

# SSH crap for linux

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
  eval `$SSHAGENT $SSHAGENTARGS`
  trap "kill $SSH_AGENT_PID" 0
fi


function ShowProc() {
  ps aux | grep $1 | grep -v grep
}
function SuperKill() {
  ps aux | grep $1 | grep -v grep | awk {' print $2 '} | xargs kill -9
}


function GemInst() {
  gem install $1 --no-ri --no-rdoc
}

function growl() {
echo -e $'\e]9;'${1}'\007' ; return
}

function EarthQuakeScreen() {
  while true; do
    earthquake -c :recent
    sleep 20
    echo `date` '=========================================>'
  done

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


# export TERM=xterm-256color
export RPS1=$RPS1' %{$fg[red]%}❖ $(rvm current | sed s/ruby-//) %{$reset_color%}'

# export EDITOR='/usr/local/Cellar/vim/7.3.333/bin/vim'
export EDITOR='vim'

export GITHUB_TOKEN=`git config --global --get github.token`
export GITHUB_USER=`git config --global --get github.user`
export ARCHFLAGS="-arch x86_64"


export GIT_SSL_NO_VERIFY=true

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=~/Dropbox/Scripts:$PATH
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=/opt/PalmSDK/Current/bin/:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

