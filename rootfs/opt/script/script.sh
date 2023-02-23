#!/bin/bash

# template

# Author: Vitali Quiering (vitali@quiering.com

set -eu

# default add version
_VERSION=${VERSION:?something went wrong, version missing}

# dummy variable
_VAR="${VAR:-true}"

##############################################################################
###################### DO NOT EDIT AFTER THIS LINE ###########################
##############################################################################

# determine where we are running and where symlinks are pointing to
_SCRIPT="$(basename -- "$0")"
_SCRIPT_DIR="$(readlink -f -- "$0")"
_SCRIPT_HOME="$(dirname -- "${_SCRIPT_DIR}")"

# get the dir the original script is running in for further sourcing
_SCRIPT_HOME="$(dirname "$(readlink -f "$0")")"

########################## LOGGING ##########################################

# Source the logging functions.
_LOG_LEVEL="${LOG_LEVEL:-INFO}"
source "${_SCRIPT_HOME}/includes/logging.sh"

#############################################################################

logInfo "version: ${_VERSION}"
logInfo "template: ${_VAR}"

exit 0