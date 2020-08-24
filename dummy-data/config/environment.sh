#!/usr/bin/env sh

# This file sets up a dummy mpv binary so builds.sr.ht doesn't have
# to download and install mpv and its full tree of dependencies for
# every build :)

_ENV_SH_TMP_DIR="$(mktemp -d -t "wtwitch_XXXXXXXX")"
touch "${_ENV_SH_TMP_DIR}/mpv"
PATH="${PATH}:${_ENV_SH_TMP_DIR}"
