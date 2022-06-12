# PS1
__tf_workspace() {
  if [[ -d .terraform ]]; then
    local workspace="$(terraform workspace show)"
    echo -n "[${workspace}]"
  fi
}

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\w$(__git_ps1)$(__tf_workspace)\n$ '


# alias
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

if [[ $(uname) == 'Darwin' ]]; then
  alias ls='ls -GF'
else
  alias ls='ls --color=auto -F'
fi
alias la='ls -A'
alias ll='ls -alh'

alias r='cd $(ghq root)/$(ghq list | fzf)'
alias h='clear && tldr'
alias dc='docker compose'
alias dw='diff2html -i stdin'
alias tf='terraform'

if [[ $(uname) == 'Linux' ]]; then
  alias pbcopy='xclip -selection c'
  alias pbpaste='xclip -selection c -o'
fi

# functions
function col() {
  awk -v col=$1 '{print $col}'
}

function mkdircd() {
  mkdir -p $1
  cd $1
}

# apps
source $HOME/.fzf.bash

source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

eval "$(gh completion -s bash)"

source $HOME/.local/bin/bashmarks.sh

source $HOME/.local/bin/plug_completion.sh
