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

alias gs='git status'
alias testenv='RAILS_ENV=test '
alias staging='ssh lukasz@staging.billmonitor.com'
alias install_this_mysql_gem='ARCHFLAGS="-arch x86_64" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config '
alias prev='qlmanage -p '

function ShowProc() {
  ps aux | grep $1 | grep -v grep
}
function SuperKill() {
  ps aux | grep $1 | grep -v grep | awk {' print $2 '} | xargs kill -9
}

function Grep() {
  grep -cnHir $1
}
# PATH crap

export PATH=/opt/local/bin:/opt/local/sbin:/Users/lukasz/bin:/opt/local/lib/ruby/gems/1.8/gems/:$PATH
export PATH=/Users/lukasz/.gem/ruby/1.8/bin:$PATH
export PATH=/opt/local/lib:$PATH
export PATH=/Users/optimor/.gem/ruby/1.8/bin:$PATH
export PATH=/Users/lukaszkorecki/Dev/Tools:$PATH
export PATH=/Users/optimor/Tools:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/opt/PalmSDK/Current/bin/:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
