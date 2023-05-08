#!/bin/bash

SCRIPT_NAME="$(basename "$0")"

RESOLVER="8.8.8.8"
COLUMN_WIDTH=40


function digger {
  local domain result ns a

  domain="${1}"
  shift

  result=$(dig -4 A "${domain}" +trace +nodnssec @"${RESOLVER}" | grep "^${domain}")
  ns=$(sed '/IN\sA\s/q' <<< "${result}" | awk '/IN\sNS\s/ {gsub(/.$/,""); print $NF}')
  a=$(awk '/IN\sA\s/ {print $NF}' <<< "${result}")
  paste <(echo "${domain}") <(echo "${ns:-NA}") <(echo "${a:-NA}") | expand -t "$((COLUMN_WIDTH+1))"
  echo
}


function get_input {
  local input

  echo "➜  Paste domains and press <ENTER> twice to proceed:"
  input="$(sed '/^$/q' | awk '{print tolower($0)}')"
  DOMAINS="$(grep -Eo "\b[a-z0-9.-]+\.[a-z0-9-]{2,}\b" <<< "${input}" | sed 's/^www\.//g' | sort -u)"
  [[ -z "${DOMAINS}" ]] && { echo "error: ${SCRIPT_NAME}: no valid domains parsed" >&2; exit 1; }
}


function main {
  get_input
  printf "%-${COLUMN_WIDTH}s %-${COLUMN_WIDTH}s %-${COLUMN_WIDTH}s\n\n" "DOMAIN" "NS" "IP"
  for domain in ${DOMAINS}; do
    { digger "${domain}" & } 2>/dev/null
  done
  wait
}

main
