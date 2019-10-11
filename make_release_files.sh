#!/bin/sh
#
# Description: Makes release files for wtwitch.
#
# Homepage: https://gitlab.com/krathalan/wtwitch
#
# Copyright (C) 2019 krathalan
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

# -----------------------------------------
# -------------- Guidelines ---------------
# -----------------------------------------

# This script follows the Google Shell Style Guide: 
# https://google.github.io/styleguide/shell.xml

# This script uses shellcheck: https://www.shellcheck.net/

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eu # (Eo pipefail) is Bash only!

# -----------------------------------------
# ----------- Program variables -----------
# -----------------------------------------

# Colors
readonly RED=$(tput bold && tput setaf 1)
readonly NC=$(tput sgr0) # No color/turn off all tput attributes

# Miscellaneous
readonly DOWNLOADS_PATH="${HOME}/Downloads"
readonly SCRIPT_NAME=$(basename "$0")
readonly VERSION="$(grep "VERSION=" wtwitch | cut -d "\"" -f2 | cut -d "\"" -f1)"
readonly TARBALL="wtwitch-${VERSION}.tar.gz"

# -----------------------------------------
# ------------- User variables ------------
# -----------------------------------------

# -----------------------------------------
# --------------- Functions ---------------
# -----------------------------------------

#######################################
# Prints passed error message before premature exit.
# Prints everything to >&2 (STDERR).
# Globals:
#   RED, NC
#   SCRIPT_NAME
# Arguments:
#   $1: error message to print
# Returns:
#   none
#######################################
exit_script_on_failure() 
{
  printf "%sError%s: %s\n" "${RED}" "${NC}" "$1" >&2
  printf "Exiting %s Bash script.\n" "${SCRIPT_NAME}" >&2

  exit 1
}

# -----------------------------------------
# ---------------- Script -----------------
# -----------------------------------------

printf "Making wtwitch release files..."

if [ "$(whoami)" = "root" ]; then
  exit_script_on_failure "This script should NOT be run as root (or sudo)!"
fi

if [ ! -x "$(command -v scdoc)" ]; then
  exit_script_on_failure "You need to have scdoc installed to build the man page."
fi

# Create man page
scdoc < wtwitch.1.scd > wtwitch.1

# Create tarball
tar -czf "${TARBALL}" wtwitch wtwitch.1

# Create signature and checksum files
gpg --output "${TARBALL}.sig" --detach-sig "${TARBALL}"
sha256sum "${TARBALL}" > sha256sums
sha256sum "${TARBALL}.sig" >> sha256sums

# Remove leftover files
rm -f wtwitch.1

# Move/copy release files to Downloads folder for uploading
mv "${TARBALL}" "${DOWNLOADS_PATH}"
mv "${TARBALL}.sig" "${DOWNLOADS_PATH}"
mv "sha256sums" "${DOWNLOADS_PATH}"
cp "CHANGELOG" "${DOWNLOADS_PATH}"

printf "done.\n"
