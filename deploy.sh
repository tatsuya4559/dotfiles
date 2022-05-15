#!/bin/bash
set -eu
readonly SCRIPT_DIR=$(cd $(dirname \$0); pwd)

DEBUG=true
DRY_RUN=echo
FORCE=false

function log() {
  if ! ${DEBUG}; then
    return 0
  fi

  local severity="$1"
  local message="${@:2}"
  echo "[${severity}] ${message}" 1>&2
}

function symlink() {
  local filename=$1
  local src="${SCRIPT_DIR}/dotfiles/${filename}"
  local dest="${HOME}/${filename}"
  # FIXME: linkが切れていると処理を続行してしまう
  if [[ -e "${dest}" ]]; then
    log WARN "${dest} already exists. symlink skipped."
    return 0
  fi
  log INFO "symlink ${src} to ${dest}."
  ${DRY_RUN} ln -s "${src}" "${dest}"
}

function copy() {
  local filename=$1
  local src="${SCRIPT_DIR}/dotfiles/${filename}"
  local dest="${HOME}/${filename}"
  if [[ -e "${dest}" ]]; then
    log WARN "${dest} already exists. copy skipped."
    return 0
  fi
  log INFO "copy ${src} to ${dest}."
  ${DRY_RUN} cp -n "${src}" "${dest}"
}

function deploy_files() {
  while read -r filename; do
    symlink ${filename}
  done < "${SCRIPT_DIR}/symlink.conf"

  while read -r filename; do
    copy ${filename}
  done < "${SCRIPT_DIR}/copy.conf"
}

function download_file() {
  local dest_filename="${HOME}/$1"
  local src_url=$2
  if [[ -e "${dest_filename}" ]]; then
    log WARN "${dest_filename} already exists. download skipped."
    return 0
  fi
  log INFO "download ${src_url} to ${dest_filename}."
  ${DRY_RUN} curl "${src_url}" -o "${dest_filename}"
}

function clone_git_repo() {
  local dest_dirname="${HOME}/$1"
  local repo_url=$2
  if [[ -e "${dest_dirname}" ]]; then
    log WARN "${dest_dirname} already exists. clone skipped."
    return 0
  fi
  log INFO "clone ${src_url} into ${dest_dirname}."
  ${DRY_RUN} git clone "${repo_url}" "${dest_dirname}"
}

function download_external() {
  while read -r filename url; do
    download_file "${filename}" "${url}"
  done < "${SCRIPT_DIR}/external_files.conf"

  while read -r dirname url; do
    clone_git_repo "${dirname}" "${url}"
  done < "${SCRIPT_DIR}/external_repos.conf"
}

function run_script_once() {
  local script_filename="${SCRIPT_DIR}/scripts/$1"
  local lock_filename="${SCRIPT_DIR}/.lock/$1"

  if ! ${DRY_RUN} ln -s "${script_filename}" "${lock_filename}" 2>/dev/null; then
    log INFO "${script_filename} skipped."
    return 0
  fi

  log INFO "run ${script_filename}."
  ${DRY_RUN} bash "${script_filename}"
  local status=$?
  if [[ "${status}" -ne 0 ]]; then
    log ERROR "${script_filename} failed."
    rm -f "${lock_filename}" || true
  fi
  return "${status}"
}

function run_scripts() {
  if [[ ! -d "${SCRIPT_DIR}/.lock" ]]; then
    mkdir "${SCRIPT_DIR}/.lock"
  fi

  while read -r filename; do
    if [[ "${filename}" =~ ^run ]]; then
      run_script_once "${filename}"
    fi
  done < <(find "${SCRIPT_DIR}/scripts" -type f | xargs basename)
}

function deploy() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -d|--dry-run)
        log INFO "set dry-run option."
        DRY_RUN=echo
        ;;
      *)
        :
        ;;
    esac
    shift
  done

  deploy_files
  download_external
  run_scripts
}

function status() {
  while read -r filename; do
    if ! git diff --quiet "${SCRIPT_DIR}/dotfiles/${filename}"; then
      echo "modified from committed: ${filename}"
    fi
  done < "${SCRIPT_DIR}/symlink.conf"

  while read -r filename; do
    if ! cmp --quiet "${SCRIPT_DIR}/dotfiles/${filename}" "${HOME}/${filename}"; then
      echo "modified from original: ${filename}"
    fi
  done < "${SCRIPT_DIR}/copy.conf"

  while read -r filename; do
    if [[ "${filename}" =~ ^run && ! -e "${SCRIPT_DIR}/.lock/${filename}" ]]; then
      echo "not executed: ${filename}"
    fi
  done < <(find "${SCRIPT_DIR}/scripts" -type f | xargs basename)
}

function diff() {
  local filename=$1
  local original="${SCRIPT_DIR}/dotfiles/${filename}"
  local deployed="${HOME}/${filename}"

  local unified=false
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -u|--unified)
        log INFO "set unified option."
        unified=true
        ;;
      *)
        :
        ;;
    esac
    shift
  done

  if ${unified}; then
    git diff --no-index "${original}" "${deployed}"
  else
    vimdiff "${original}" "${deployed}"
  fi
}

function clear() {
  log INFO "clear lock files."
  ${DRY_RUN} rm -f "${SCRIPT_DIR}/.lock/*"
}

function add() {
  # TODO: copy, symlink, externalのconfにも追記する
  local filepath="$1"
  local dir=$(dirname "${filepath}")
  log INFO "add ${filepath} under dotfiles management."
  ${DRY_RUN} mkdir -p "${SCRIPT_DIR}/${dir}"
  ${DRY_RUN} cp -a "${HOME}/${filepath}" "${SCRIPT_DIR}/dotfiles/${filepath}"
  ${DRY_RUN} git -C "${SCRIPT_DIR}" add "dotfiles/${filepath}"
}

readonly SUBCOMMAND=$1; shift
case "${SUBCOMMAND}" in
  deploy)
    deploy $@
    ;;
  status)
    status
    ;;
  diff)
    if [[ $# -lt 1 ]]; then
      echo "Usage: $0 diff <filename> [OPTION]" 1>&2
      echo "  -u  --unified  Show unified diff." 1>&2
      exit 1
    fi
    diff $@
    ;;
  clear)
    clear
    ;;
  add)
    add $@
    ;;
  noop)
    :
    ;;
  *)
    # TODO: show usage
    echo invalid subcommand
    exit 1
    ;;
esac
