if [[ $(uname) == 'Darwin' ]]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1
fi

export LANG=ja_JP.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR='vim'

HISTSIZE=10000
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
export PROMPT_COMMAND='history -a'

export PATH="$HOME/.local/bin:$PATH"
export FZF_DEFAULT_COMMAND='fd --color never --type f'

if [[ $(uname) == 'Linux' ]]; then
  eval $("$HOME/.linuxbrew/bin/brew" shellenv)
fi

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# golang
export PATH=$PATH:$(go env GOPATH)/bin

if [[ -f $HOME/.bashrc ]]; then
    source "$HOME/.bashrc"
fi
