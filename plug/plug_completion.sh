#!/bin/bash
# bash completion for plug
_plug() {
  local cur prev words cword
  _get_comp_words_by_ref -n : cur prev words cword

  if [[ ${cword} -gt 2 ]]; then
    # make completion based on subcommand
    prev=${words[1]}
  fi

  case "${prev}" in
  plug)
    local subcommands="install uninstall ls enable disable"
    COMPREPLY=($(compgen -W "${subcommands}" -- "${cur}"))
    ;;
  uninstall)
    local plugins
    plugins=$(cat <(\ls ~/.vim/pack/plug/start) <(\ls ~/.vim/pack/plug/disabled))
    COMPREPLY=($(compgen -W "${plugins}" -- "${cur}"))
    ;;
  enable)
    local plugins
    plugins=$(\ls "$HOME/.vim/pack/plug/disabled")
    COMPREPLY=($(compgen -W "${plugins}" -- "${cur}"))
    ;;
  disable)
    local plugins
    plugins=$(\ls "$HOME/.vim/pack/plug/start")
    COMPREPLY=($(compgen -W "${plugins}" -- "${cur}"))
    ;;
  esac
} && complete -F _plug plug
