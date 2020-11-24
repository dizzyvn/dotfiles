# History control
# don't use duplicate lines or lines starting with space
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
# append to the history file instead of overwrite
shopt -s histappend

# Aliases
alias cp='cp -Rv'
alias ls='ls --color=auto -ACF'
alias ll='ls --color=auto -alF'
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias wget='wget -c'

alias gadd='git add'
alias gcom='git commit'
alias gsup='git status'
alias goto='git checkout'

alias pip='pip3'
alias pym='python3 manage.py'
alias mkenv='python3 -m venv env'
alias startenv='source env/bin/activate && which python3'
alias stopenv='deactivate'

# Use programs without a root-equivalent group
alias npm='sudo npm'

# Show contents of dir after action
function cd () {
    builtin cd "$1"
    ls -ACF
}

# Bash completion
source ~/.git-completion.bash

# Color prompt
export TERM=xterm-256color

# Allow Unfree package for Nix
export NIXPKGS_ALLOW_UNFREE=1

# Hook direnv
eval "$(direnv hook bash)"

# Port forwarding
function convertnb() {
    sed -e 's/"outputPrepend",//g' "$1".ipynb | sed -r '/^\s*$/d' > _tmp.ipynb
    jupyter nbconvert --to python _tmp.ipynb --output $1.py
    rm _tmp.ipynb
}

function runnb() {
    sed -e 's/"outputPrepend",//g' "$1".ipynb | sed -r '/^\s*$/d' > _tmp.ipynb
    jupyter nbconvert --to python _tmp.ipynb --output $1.py
    rm _tmp.ipynb
    python $1.py
}

function setup_ssh(){
    local port="${2:-6000}"
    local target="192.168.100.22"
    ssh -L "$port":"$target":22 gateway
}

function forward(){
    local host="${1:-mdl-tran}"
    local port="${2:-8888}"
    ssh -N -f -L localhost:"$port":localhost:"$port" "$host"
}

source ~/Dropbox/private_dotfiles/.private
