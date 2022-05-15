assert_stderr() {
  local want="$1"; shift
  got="$($@ 2>/dev/stdout 1>/dev/null)"
  [[ "${got}" == "${want}" ]]
}

expect_stderr() {
  local cmd=()
  local want
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --to-be)
        shift
        want=$1
        ;;
      *)
        cmd+=("$1")
        ;;
    esac
    shift
  done

  got="$(${cmd[@]} 2>/dev/stdout 1>/dev/null)"
  [[ "${got}" == "${want}" ]]
}
