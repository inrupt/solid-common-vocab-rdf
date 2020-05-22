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
DEFAULT_TARGET_DIR="./src/ExternalVocab"
TARGET_DIR="${PWD}/${DEFAULT_TARGET_DIR}"
GIT_REPOSITORY_URL="git@github.com:inrupt/lit-artifact-generator.git"
GIT_BRANCH="master"
GIT_VERSION_TAG=""

source ${SCRIPT_DIR}/run_command.sh

helpFunction() {
    printf "${BLUE}Usage: $0 [ -t TargetDirectory ] [ -b GitBranch ]\n"
    printf "Fetchs the LIT Artifact Generator (with optional Git branch) into the target directory.${NORMAL}\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-t ${BLUE}Optional: target directory (default is: [${DEFAULT_TARGET_DIR}])${NORMAL}\n"
    printf "\t-b ${BLUE}Optional: Git branch (default is: [${GIT_BRANCH}])${NORMAL}\n\n"
    printf "${GREEN}Current working directory: [${PWD}]${NORMAL}\n"
    printf "${GREEN}Target directory: [${TARGET_DIR}]${NORMAL}\n"
    printf "${GREEN}Script directory: [${SCRIPT_DIR}]${NORMAL}\n"
}

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

while getopts ":t:b:" opt
do
    case "$opt" in
      t ) TARGET_DIRECTORY="$OPTARG" ;;
      b ) GIT_BRANCH="$OPTARG" ;;
      ? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done

if [ -d "${TARGET_DIR}/lit-artifact-generator" ]
then
    run_command "cd ${TARGET_DIR}/lit-artifact-generator"
    run_command "git checkout ${GIT_BRANCH}"
    run_command "git fetch"
    run_command "git rebase origin/${GIT_BRANCH}"
else
    run_command "mkdir -p ${TARGET_DIR}"
    run_command "cd ${TARGET_DIR}"
    run_command "git clone -b ${GIT_BRANCH} ${GIT_REPOSITORY_URL}${GIT_VERSION_TAG}"

    LOCAL_REPOSITORY_DIR="$(echo ${GIT_REPOSITORY_URL} | sed 's/^.*\///' | sed 's/\..*$//')"
    run_command "cd ${LOCAL_REPOSITORY_DIR}"
fi

printf "\n${GREEN}Running 'npm ci' on the latest LIT Artifact Generator in directory: [${TARGET_DIR}]...${NORMAL}\n"
run_command "npm ci"
run_command "cd ${STARTING_DIR}"

printf "\n${GREEN}Successully updated to the latest LIT Artifact Generator in directory: [${TARGET_DIR}].${NORMAL}\n"
