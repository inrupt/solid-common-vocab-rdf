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

source ${SCRIPT_DIR}/run_command.sh

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
    run_command "git rebase origin/${GIT_BRANCH}"
else
    printf "${GREEN}Didn't find repository locally [${FULL_REPO_DIR}] - cloning it into directory [${TARGET_DIR}]...${NORMAL}\n"
    run_command "mkdir -p ${TARGET_DIR}"
    run_command "cd ${TARGET_DIR}"

    run_command "git clone -b ${GIT_BRANCH} ${GIT_REPO_URL}"
fi

#run_command "cd ${STARTING_DIR}"
printf "\n${GREEN}Successully cloned/updated repo [${REPO_DIR}] into directory: [${TARGET_DIR}/${REPO_DIR}].${NORMAL}\n"
