[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

# PS1
GIT_PS1_SHOWDIRTYSTATE=true
NORMAL='\[\e[m\]'
RED='\[\e[1;31m\]'
GREEN='\[\e[1;32m\]'
YELLOW='\[\e[1;33m\]'
BLUE='\[\e[1;34m\]'
PURPLE='\[\e[1;35m\]'
CYAN='\[\e[1;36m\]'
export PS1="${BLUE}\w${PURPLE}"'$(__git_ps1)'"${YELLOW}\n↪ ${NORMAL}"


# alias
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias vim='nvim'

alias ls='ls -GF'
alias la='ls -GFa'
alias ll='ls -GFalh'
alias tree='tree -C'

alias g='cd $(ghq root)/$(ghq list | fzf)'

alias h='clear && tldr'
alias dc='docker-compose'
alias a='. venv/bin/activate'
alias C='pbcopy'

#alias pbcopy='xclip -selection c'
#alias pbpaste='xclip -selection c -o'

# awkめんどい
function col() {
  awk -v col=$1 '{print $col}'
}

# vim perf
function time_vim() {
  nvim --startuptime /tmp/stime_with_plugin.log -c 'quit' > /dev/null \
    && tail -n 1 /tmp/stime_with_plugin.log | cut -d ' ' -f1
}
