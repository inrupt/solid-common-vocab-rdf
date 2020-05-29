#!/bin/bash
# set -e to exit on error.
set -e
# set -u to error on unbound variable (use ${var:-} to check if 'var' is set.
set -u
set -o pipefail

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
NORMAL=$(tput sgr0)

# Run a command.
# If execution fails, exit all execution and print an error (unless overridden
# with the '-f' (Force) command-line option).
function run_command {
    local COMMAND="$1"
    local ALLOW_FAILURE=false

    if [ "${1:-}" == '-f' ] ;
    then
      ALLOW_FAILURE=true
      COMMAND="$2"
      set +e
    else
      COMMAND="$1"
    fi

    printf "${GREEN}[EXEC] ${YELLOW}$COMMAND${NORMAL} [Allow failure: ${ALLOW_FAILURE}]\n"
    $COMMAND
    RESULT=$?
    if [ ${RESULT} -ne 0 ] ;
    then
      if [ ${ALLOW_FAILURE} == false ] ;
      then
          printf "${RED}[ERROR] Failed to execute command: [$COMMAND], with exit code [${RESULT}]${NORMAL}\n"
          exit $?
      else
          printf "${YELLOW}Failed to execute command: [$COMMAND], with exit code [${RESULT}], but continuing...${NORMAL}\n\n"
      fi
    fi
}
