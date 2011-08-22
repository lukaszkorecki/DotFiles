# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="dst"

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
plugins=(osx git rvm bundler ruby rails rails3)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Aliases

alias palm-tunnel='ssh -p 5522 -L 5581:localhost:8080 root@localhost'
alias gs='git status'
alias gco='git commit -m '
alias testenv='RAILS_ENV=test '
alias install_this_mysql_gem='ARCHFLAGS="-arch x86_64" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config '
alias prev='qlmanage -p '
function git(){hub "$@"}

alias vitodo='mvim ~/Dropbox/todo/todo.txt'

function ShowProc() {
  ps aux | grep $1 | grep -v grep
}
function SuperKill() {
  ps aux | grep $1 | grep -v grep | awk {' print $2 '} | xargs kill -9
}

function Grep() {
  grep -cnHir $1
}

function CopyPwd() {
  pwd | pbcopy
}
function GotoPath() {
  cd `pbpaste`
}

function GrepFind() {
  echo "Searching in ".`pwd`
  find -L -f . | grep $1
}

function GemInst() {
  gem install $1 --no-ri --no-rdoc
}


export EDITOR='vim --noplugin -u ~/.DotFiles/.simplerc'

# PATH crap
export PATH=/usr/local/bin:$PATH
export PATH=~/Dropbox/Scripts:$PATH
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=/opt/PalmSDK/Current/bin/:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.