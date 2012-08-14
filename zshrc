export LANG=en_GB.UTF-8
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/r20.0.1

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# export PATH=/home/lukasz/.gem/ruby/1.8/bin:$PATH
export PATH=$HOME/.DotFiles/bins:$PATH
export PATH=~/Dropbox/Scripts:$PATH

export PATH=/usr/local/mysql/bin:$PATH
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"

if [[ -f ~/Dropbox/zaku_ip ]]; then
  export ZAKUIP=`cat ~/Dropbox/zaku_ip || ''`
fi


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

# Aliases

alias r='rails' # sigh
alias rake='noglob rake' # stop rake's params from being treated as ZSH patterns
alias history='fc -l 1'

alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc'
function psgr(){
  ps aux | grep $1 | grep -v grep
}

# work out which ls version we're dealing with
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'

alias tm='tmux -2 -u'
alias tm-join='tmux -2 -u new-session -t '
alias be='bundle exec '
alias install_this_mysql_gem='ARCHFLAGS="-arch x86_64" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config '

alias ng="~/.nginx/sbin/nginx"

if  [[ -e /usr/bin/ack-grep ]]; then
  alias ack='ack-grep'
fi

# VIM stuff
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

# edit modified files in vim
# use vim as man viewer
function viman() {
env PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nolist nonumber' -c 'map q :q<CR>' \
  -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"" man $*
}

function EditHost() {
  sudo vim /etc/hosts
  dscacheutil -flushcache
}

function grep-files() {
  echo "searching everywhere! Add file ext to limit the scope"
  for f in ls ./*$2; do ; egrep -nHr --color $1 $f; done
}

# lolz
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
function KillMatching() {
  ps aux | grep $1 | egrep -v "grep|tmux" | awk '{ print $2 } ' | xargs kill -9
}

# git tools -------------------------------------------------------------------
function github-clone() {
echo "cloning $1 via https by default, pass an extra arg for git protocol"
prefix='git@github.com:'
if [[ -z "$2" ]] ; then
  prefix='https://github.com/'
fi
git clone $prefix$1.git
}
function git-yest(){
   _d=`date -v -1d "+%Y-%m-%d"`
  echo "Showing commits since $_d"
  git --no-pager log --since $_d
}

function git-vim-modified() {
  vim -O $(gs --porcelain | awk '{ print $2 }' | tr "\n", ' ' )
}

function git-grep-vim() {
  if [[ -z "$2" ]]; then
    cond=tee
    filter='[no filter]'
  else
    cond="grep $2"
    filter="[$cond]"
  fi
  echo "Searching for '$1' with filter: $filter"
  vim -O $(git grep $1 | eval $cond | cut -s -d : -f 1 | tr " ", "\\ " )

}


alias gs='git status'
alias gco='git commit'
alias gc='git commit'
alias git-pull-all='git pull --recurse-submodules '
alias ggp='git --no-pager grep --color -n '
alias glo='git log --graph --oneline'
alias gpr='git pull --rebase'

function Mutt() {
  TERM=screen-256color mutt -e "source ~/.private/mutt_$1"
}

function Mcabber() {
  TERM=screen-256color mcabber -f ~/.private/jabber_$1.conf
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
  local br=$(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{ print $3 }') # || { echo "$@" ; exit ; }
  echo $br
}
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Prompt
setopt prompt_subst
autoload -U colors && colors
local sigil='%{$fg[red]%}#%{$reset_color%}'
local rvm_ruby='%{$fg[red]%}$(~/.rvm/bin/rvm-prompt i v g s)%{$reset_color%}'
local host='%{$fg[blue]%}%m%{$reset_color%}'
local git_branch='%{$fg[green]%}$(GitCurrentBranch)%{$reset_color%}'
local c_path='%{$fg[yellow]%}%~%{$reset_color%}'
PROMPT="${host} %n ${sigil} "
RPROMPT="${git_branch} ${c_path} ${rvm_ruby}"

source ~/.DotFiles/zsh/highlight/zsh-syntax-highlighting.zsh
