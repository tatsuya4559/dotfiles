if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
export BASH_SILENCE_DEPRECATION_WARNING=1
export LANG=ja_JP.UTF-8
export LC_CTYPE=en_US.UTF-8
export TERM=xterm-256color
export EDITOR='vim'

export FZF_DEFAULT_COMMAND='fd --color never --type f'
export PATH=$PATH:/usr/local/opt.coreutils/libexec/gnubin

HISTSIZE=10000
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '

# go
export GOPATH=`go env GOPATH`
export PATH=$PATH:$GOPATH/bin

