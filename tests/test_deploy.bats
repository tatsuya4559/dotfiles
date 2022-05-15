#!/usr/bin/env bats
setup() {
  source ./test_helper.sh
  source ../deploy.sh noop
}

@test "log output to stderr if DEBUG=true" {
  DEBUG=true
  expect_stderr log ERROR 'got an error' \
    --to-be '[ERROR] got an error'
}

@test "log output suppressed if DEBUG=false" {
  DEBUG=false
  expect_stderr log ERROR 'got an error' \
    --to-be ''
}
# vim: ft=sh
