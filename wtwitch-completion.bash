#!/usr/bin/env bash
#
# Description: Bash completion file for wtwitch.
#    Homepage: https://git.sr.ht/~krathalan/wtwitch
#
# Copyright (C) 2020 krathalan
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

#######################################
# This is a simple wrapper around a case statement to
# allow for simple string comparisons against globs.
# Copyright (C) 2016-2019 Dylan Araps
# Globals:
#   none
# Arguments:
#   $1: string to check against glob
#   $2: glob
# Returns:
#   true or false
#######################################
_glob()
{
  # Disable this warning as it is the intended behavior.
  # shellcheck disable=2254
  case $1 in $2) return 0; esac; return 1
}

#######################################
# Converts a string to lowercase.
# Globals:
#   none
# Arguments:
#   $1: string to convert
# Returns:
#   none
#######################################
_to_lowercase() {
  printf "%s\n" "${1,,}"
}

#######################################
# Sets the appropriate $COMPREPLY for the user's input.
# Globals:
#   COMP_WORDS
#   COMPREPLY
#   XDG_CONFIG_HOME
#   HOME
# Arguments:
#   none
# Returns:
#   none
#######################################
_wtwitch_completions()
{
  # COMP_WORDS[0] = wtwitch
  # COMP_WORDS[1] = cmd (e.g. w, c, etc.)

  if [[ "${#COMP_WORDS[@]}" -lt "3" ]]; then
    mapfile -t COMPREPLY <<< "$(compgen -W "w s u c e n g t l p q b v help" "${COMP_WORDS[1]}")"
  elif _glob "${COMP_WORDS[1]}" "[w]" && [[ "${#COMP_WORDS[@]}" == "3" ]]; then
    if [[ "${#COMP_WORDS[@]}" != "3" ]]; then
      return
    fi

    # Get cache of online subscriptions
    wtwitch c &> /dev/null

    # Get a list of online subscriptions
    mapfile -t _user_subscriptions <<< "$(jq -r ".subscriptions[].streamer" "${XDG_CONFIG_HOME:-${HOME}/.config}/wtwitch/config.json")"

    _online_subscriptions=()
    _online_subscriptions_file_text="$(<"${XDG_CACHE_HOME:-${HOME}/.cache}/wtwitch/stream_online.txt")"
    _online_subscriptions_file_text="$(_to_lowercase "${_online_subscriptions_file_text}")"

    for _subscription in "${_user_subscriptions[@]}"; do
      if [[ "${_online_subscriptions_file_text}" == *"${_subscription}"* ]]; then
        _online_subscriptions+=("${_subscription}")
      fi
    done

    # Return list of online subscriptions
    mapfile -t COMPREPLY <<< "$(compgen -W "${_online_subscriptions[*]}" "${COMP_WORDS[2]}")"
  elif _glob "${COMP_WORDS[1]}" "[u]" && [[ "${#COMP_WORDS[@]}" == "3" ]]; then
    mapfile -t _user_subscriptions <<< "$(jq -r ".subscriptions[].streamer" "${XDG_CONFIG_HOME:-${HOME}/.config}/wtwitch/config.json")"
    mapfile -t COMPREPLY <<< "$(compgen -W "${_user_subscriptions[*]}" "${COMP_WORDS[2]}")"
  fi
}

complete -F _wtwitch_completions wtwitch