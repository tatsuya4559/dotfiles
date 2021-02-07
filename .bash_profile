if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
export BASH_SILENCE_DEPRECATION_WARNING=1
export LANG=ja_JP.UTF-8
export LC_CTYPE=en_US.UTF-8
export TERM=xterm-256color
export EDITOR='vim'

export FZF_DEFAULT_COMMAND='rg --color never --files --hidden --follow --glob "!.git/*"'
export PATH=$PATH:/usr/local/opt.coreutils/libexec/gnubin

HISTSIZE=10000
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '

# node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# go
export GOPATH=`go env GOPATH`
export PATH=$PATH:$GOPATH/bin

# python
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
