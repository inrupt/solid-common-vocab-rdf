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

# We default to installing the LAG in a sibling directory (that we explicitly
# add to our repo's .gitignore file) of this script directory.
TARGET_DIR="${SCRIPT_DIR}/../bin"

GIT_REPOSITORY_URL="git@github.com:inrupt/lit-artifact-generator.git"
GIT_BRANCH="master"
GIT_VERSION_TAG=""

source ${SCRIPT_DIR}/run_command.sh

helpFunction() {
    printf "${BLUE}Usage: $0 [ -t TargetDirectory ] [ -b GitBranch ]\n"
    printf "Fetchs the LIT Artifact Generator (with optional Git branch) into the target directory.${NORMAL}\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-t ${YELLOW}Optional: ${BLUE}Target directory (default is: [${YELLOW}${TARGET_DIR}${BLUE}])${NORMAL}\n"
    printf "\t-b ${YELLOW}Optional: ${BLUE}Git branch (default is: [${YELLOW}${GIT_BRANCH}${BLUE}])${NORMAL}\n\n"
    printf "${RED}Current working directory: [${PWD}]${NORMAL}\n"
    printf "${RED}Target directory: [${TARGET_DIR}]${NORMAL}\n"
    printf "${RED}Script directory: [${SCRIPT_DIR}]${NORMAL}\n"
}

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

while getopts ":t:b:" opt
do
    case "$opt" in
      t ) TARGET_DIR="$OPTARG" ;;
      b ) GIT_BRANCH="$OPTARG" ;;
      ? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done

LAG_DIR="${TARGET_DIR}/lit-artifact-generator"

if [ -d "${LAG_DIR}" ]
then
    printf "${GREEN}Found LIT Artifact Generator locally in [${LAG_DIR}] - ensuring branch [${GIT_BRANCH}] is up-to-date...${NORMAL}\n"
    run_command "cd ${LAG_DIR}"
    run_command "git checkout ${GIT_BRANCH}"
    run_command "git fetch"
    run_command "git rebase origin/${GIT_BRANCH}"
else
    printf "${GREEN}Didn't find LIT Artifact Generator locally [${LAG_DIR}] - cloning it into directory [${TARGET_DIR}]...${NORMAL}\n"
    run_command "mkdir -p ${TARGET_DIR}"
    run_command "cd ${TARGET_DIR}"
    run_command "git clone -b ${GIT_BRANCH} ${GIT_REPOSITORY_URL}${GIT_VERSION_TAG}"

    # We could just use the 'LAG_DIR' variable here too,
    LOCAL_REPOSITORY_DIR="$(echo ${GIT_REPOSITORY_URL} | sed 's/^.*\///' | sed 's/\..*$//')"
    run_command "cd ${LOCAL_REPOSITORY_DIR}"
fi

printf "\n${GREEN}Running 'npm ci' on the latest LIT Artifact Generator in directory: [${TARGET_DIR}]...${NORMAL}\n"
run_command "npm ci"
run_command "cd ${STARTING_DIR}"

printf "\n${GREEN}Successully updated to the latest LIT Artifact Generator in directory: [${TARGET_DIR}].${NORMAL}\n"
