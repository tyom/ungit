#!/usr/bin/env bash
# Offline smoke tests: flag parsing and error handling (no network).
set -uo pipefail

cd "$(dirname "$0")"
UNGIT=./ungit
pass=0
fail=0

check() {
  local desc="$1" expected="$2" actual="$3"
  if [[ "$actual" == *"$expected"* ]]; then
    ((pass++))
  else
    echo "FAIL: $desc"
    echo "  expected to contain: $expected"
    echo "  got: $actual"
    ((fail++))
  fi
}

check "--version"      "ungit version"        "$($UNGIT --version)"
check "--help"         "Download a repository" "$($UNGIT --help)"
check "no args = help" "Usage: ungit"          "$($UNGIT)"
check "bad format"     "Invalid format"        "$($UNGIT 'not a repo' 2>&1 || true)"
check "missing -i arg" "requires a pattern"    "$($UNGIT -i 2>&1 || true)"
check "unknown option" "Unknown option"        "$($UNGIT -x user/repo 2>&1 || true)"
check "flag after src" "Options must come"     "$($UNGIT user/repo -p 2>&1 || true)"

echo "passed: $pass, failed: $fail"
[[ $fail -eq 0 ]]
