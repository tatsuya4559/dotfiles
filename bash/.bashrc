# PS1
__tf_workspace() {
  if [[ -d .terraform ]]; then
    echo -n "[$(terraform workspace show)]"
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
alias gg='git grep --heading --break'
alias gj='git jump grep'

if [[ $(uname) == 'Linux' ]]; then
  alias pbcopy='xclip -selection c'
  alias pbpaste='xclip -selection c -o'
fi

# functions
col() {
  awk -v col=$1 '{print $col}'
}

mkdircd() {
  mkdir -p "$1"
  cd "$1"
}

ggl() {
  local search_words
  search_words=$(tr ' ' '+' <<< "$*")
  if [[ $(uname) == 'Darwin' ]]; then
    open "https://www.google.com/search?q=${search_words}"
  else
    xdg-open "https://www.google.com/search?q=${search_words}"
  fi
}

z() {
  local root dir
  root=$(git rev-parse --show-superproject-working-tree --show-toplevel | head -1)

  case "$1" in
    '-h' | '--help')
      cat <<EOF
Usage: z
z => cd to any dir in repo
z . => cd to repo root
EOF
      return 0
      ;;
    '.')
      cd "${root}" || true
      return 0
      ;;
    *)
      dir=$(cd "${root}" || true; fd --hidden --type d --color never "" | fzf)
      dir="${root}/${dir}"
      cd "${dir}" || true
      ;;
  esac
}

# apps
source "$HOME/.fzf.bash"
source "$HOME/.git-completion.bash"
source "$HOME/.git-prompt.sh"
source "$HOME/.local/bin/bashmarks.sh"
source "$HOME/.local/bin/plug_completion.sh"

eval "$(gh completion -s bash)"
eval "$(direnv hook bash)"
