# PS1
__tf_workspace() {
  if [[ -d .terraform ]]; then
    echo -n "[$(terraform workspace show)]"
  fi
}

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\w$(__git_ps1)$(__tf_workspace)\n$ '

# colima docker
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

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

start_colima() {
  colima start --cpu 4 --memory 4 --disk 100
}

edit_current_line() {
    local tmpfile=$(mktemp)
    echo "$READLINE_LINE" > $tmpfile
    vim $tmpfile -c 'normal $' -c 'set filetype=sh'
    READLINE_LINE="$(cat $tmpfile)"
    READLINE_POINT=${#READLINE_LINE}
    rm $tmpfile
}
bind -m emacs-standard -x '"\C-t": edit_current_line'

complete -C /.../awscli/latest/bin/aws_completer aws

awslogin() {
  saml2aws login --skip-prompt
}

# Terraform
tfinit() {
  terraform init -backend-config="profile=***"
}

tfdoc() {
  pre-commit run terraform_docs
}

pr() {
  git push -u
  git pr
}

# Misc
sound() {
  afplay /System/Library/Sounds/Funk.aiff
  # afplay /System/Library/Sounds/Glass.aiff
}

genkeypair() {
  openssl genrsa -out key.pem
  openssl rsa -pubout -in key.pem -out pubkey.pem
}

checkmyip() {
  curl http://checkip.amazonaws.com/
}

set_docker_host() {
  export DOCKER_HOST=$(docker context inspect $(docker context show) | jq -r '.[0].Endpoints.docker.Host')
}


# apps
source "$HOME/.fzf-key-bindings.bash"
source "$HOME/.git-completion.bash"
source "$HOME/.git-prompt.sh"
source "$HOME/.local/bin/bashmarks.sh"
source "$HOME/.local/bin/plug_completion.sh"

eval "$(gh completion -s bash)"
eval "$(direnv hook bash)"

# kubectl
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
