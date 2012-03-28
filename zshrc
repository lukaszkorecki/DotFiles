export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/home/lukasz/.gem/ruby/1.8/bin:$PATH
export PATH=~/Dropbox/Scripts:$PATH
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=$HOME/.DotFiles/bins/incognito_chrome:$PATH
export PATH=/opt/PalmSDK/Current/bin/:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"

export ZAKUIP=`cat ~/Dropbox/zaku_ip`
export LANG=en_US.UTF-8 # why?

export EDITOR=vim

setopt prompt_subst

export LSCOLORS="Gxfxcxdxbxegedabagacad"

export WORDCHARS=''

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


# History

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
zstyle ':completion:*' menu select
setopt completealiases
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
      'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

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

# Aliases
alias history='fc -l 1'

# work out which ls version we're dealing with
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'

alias tm='tmux -2 -u'
alias be='bundle exec '
alias gs='git status'
alias gco='git commit'
alias gc='git commit'
alias install_this_mysql_gem='ARCHFLAGS="-arch x86_64" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config '

alias ng="~/.nginx/sbin/nginx"
alias grp='grep -nHr --color '
alias ggp='git --no-pager grep --color '

alias vless='/usr/local/share/vim/vim73/macros/less.sh'

if  [[ -e /usr/bin/ack-grep ]]; then
  alias ack='ack-grep'
fi

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

function viman() {
env PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
  -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"" man $*
}

export GITHUB_TOKEN=`git config --global --get github.token`
export GITHUB_USER=`git config --global --get github.user`
export ARCHFLAGS="-arch x86_64"
export GIT_SSL_NO_VERIFY=true # sigh, self-signed certs, inhouse git servers

# GREP
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# make less suck less
export LESS="-RSM~gIsw"

# GIT
function GitCurrentBranch() {
  BR=$(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{ print $3 }') # || { echo "$@" ; exit ; }
  echo $BR
}
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Prompt
setopt prompt_subst
autoload -U colors && colors
local rvm_ruby=' %{$fg[red]%}[$(~/.rvm/bin/rvm-prompt i v g s)]%{$reset_color%}'
local git_branch=' %{$fg[green]%}$(GitCurrentBranch)'
PROMPT="%{$fg[blue]%}%M %{$reset_color%}> %n%{$reset_color%}: "
RPROMPT="${rvm_ruby} ${git_branch} %{$fg[yellow]%}%~ %{$reset_color%}"

