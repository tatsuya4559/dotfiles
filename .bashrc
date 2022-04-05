[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh
eval "$(gh completion -s bash)"

# PS1
GIT_PS1_SHOWDIRTYSTATE=true
NORMAL='\[\e[m\]'
RED='\[\e[1;31m\]'
GREEN='\[\e[1;32m\]'
YELLOW='\[\e[1;33m\]'
BLUE='\[\e[1;34m\]'
MAGENTA='\[\e[1;35m\]'
CYAN='\[\e[1;36m\]'
export PS1="${BLUE}\w${MAGENTA}"'$(__git_ps1)'"${YELLOW}\n$ ${NORMAL}"


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
alias dc='docker-compose'
alias dw='diff2html -i stdin'

if [[ $(uname) == 'Linux' ]]; then
  alias pbcopy='xclip -selection c'
  alias pbpaste='xclip -selection c -o'
fi

# awkめんどい
function col() {
  awk -v col=$1 '{print $col}'
}
