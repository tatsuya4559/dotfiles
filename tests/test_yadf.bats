#!/usr/bin/env bats
setup() {
  source ./test_helper.sh
  source ../yadf noop
}

@test "log output to stderr if DEBUG=true" {
  DEBUG=true
  got="$(log ERROR 'got an error' 2>/dev/stdout 1>/dev/null)"
  [[ "${got}" == '[ERROR] got an error' ]]
}

@test "log output suppressed if DEBUG=false" {
  DEBUG=false
  got="$(log ERROR 'got an error' 2>/dev/stdout 1>/dev/null)"
  [[ "${got}" == '' ]]
}

# vim: ft=sh
