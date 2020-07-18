#!/usr/bin/env sh

# This file sets up a dummy mpv binary so builds.sr.ht doesn't have
# to download and install mpv and its full tree of dependencies for
# every build :)

TMP_DIR="$(mktemp -d -t "wtwitch_XXXXXXXX")"
touch "${TMP_DIR}/mpv"
PATH="${PATH}:${TMP_DIR}"
