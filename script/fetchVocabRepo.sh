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

# Get the directory this script itself is located in.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
STARTING_DIR="${PWD}"
DEFAULT_TARGET_DIR="src/ExternalVocab"
TARGET_DIR="${PWD}/${DEFAULT_TARGET_DIR}"
GIT_REPO_URL=""
GIT_BRANCH="master"

# We copy this function here to allow us use this script in pure isolation from
# anything else (i.e. so that we can drop this script into any application to
# bootstrap that application using a vocabulary repo).
#  source ${SCRIPT_DIR}/run_command.sh

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

helpFunction() {
    printf "${BLUE}Usage: $0 -r <RepositoryToClone> [ -t TargetDirectory ] [ -b GitBranch ]\n"
    printf "Clones the specified repository (with an optional branch, default is [${YELLOW}${GIT_BRANCH}${BLUE}]) into the specified target directory (default is [${YELLOW}${DEFAULT_TARGET_DIR}${BLUE}]).${NORMAL}\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-r ${BLUE}Repository to clone (e.g. git@github.com:inrupt/lit-vocab.git)${NORMAL}\n\n"
    printf "\t-t ${YELLOW}Optional: ${BLUE}target directory (default is: [${YELLOW}${DEFAULT_TARGET_DIR}${BLUE}])${NORMAL}\n\n"
    printf "\t-b ${YELLOW}Optional: ${BLUE}Git branch (default is: [${YELLOW}${GIT_BRANCH}${BLUE}])${NORMAL}\n\n"
    printf "${YELLOW}Current working directory: [${PWD}]${NORMAL}\n"
    printf "${YELLOW}Target directory: [${TARGET_DIR}]${NORMAL}\n"
    printf "${YELLOW}Script directory: [${SCRIPT_DIR}]${NORMAL}\n"
}

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

while getopts ":r:t:b:" opt
do
    case "$opt" in
      r ) GIT_REPO_URL="$OPTARG" ;;
      t ) TARGET_DIR="$OPTARG" ;;
      b ) GIT_BRANCH="$OPTARG" ;;
      ? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done

if [ "${GIT_REPO_URL:-}" == "" ]
then
    printf "${RED}You *MUST* provide a Git repository to fetch from (use option '-r')...${NORMAL}\n\n"
    helpFunction
    exit 1 # Exit script after printing help.
fi

REPO_DIR="$(echo ${GIT_REPO_URL} | sed 's/^.*\///' | sed 's/\..*$//')"
FULL_REPO_DIR="${TARGET_DIR}/${REPO_DIR}"

if [ -d "${FULL_REPO_DIR}" ]
then
    printf "${GREEN}Found repository locally in [${FULL_REPO_DIR}] - ensuring branch [${GIT_BRANCH}] is up-to-date...${NORMAL}\n"
    run_command "cd ${FULL_REPO_DIR}"
    run_command "git checkout ${GIT_BRANCH}"
    run_command "git fetch"

    # Allow failure here - e.g. if there are local changes not yet pushed back
    # (prehaps to a different collection of vocabs within the same repository).
    run_command -f "git rebase origin/${GIT_BRANCH}"
else
    printf "${GREEN}Didn't find repository locally [${FULL_REPO_DIR}] - cloning it into directory [${TARGET_DIR}]...${NORMAL}\n"
    run_command "mkdir -p ${TARGET_DIR}"
    run_command "cd ${TARGET_DIR}"

    run_command "git clone -b ${GIT_BRANCH} ${GIT_REPO_URL}"
fi

#run_command "cd ${STARTING_DIR}"
printf "\n${GREEN}Successully cloned/updated repo [${REPO_DIR}] into directory: [${TARGET_DIR}/${REPO_DIR}].${NORMAL}\n"
