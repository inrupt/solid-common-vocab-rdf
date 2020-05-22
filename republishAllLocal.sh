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

helpFunction() {
    printf "Usage: $0\n"
    printf "${BLUE}Executes the LIT Artifact Generator to re-generate and re-publish ${RED}(LOCALLY)${BLUE} artifacts from all YAML files found from here.${NORMAL}\n"
}

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

if [ "${1:-}" != "" ]
then
    printf "${RED}Unknown command-lne argument: [${1}]${NORMAL}\n\n"
    helpFunction
    exit 1 # Exit script after printing help.
fi

${SCRIPT_DIR}/fetchLag.sh

printf "\n${BLUE}Executing the LIT Artifact Generator to re-generate and re-publish ${RED}(LOCALLY)${BLUE} artifacts from all YAML files found from here.${NORMAL}\n"

node ${SCRIPT_DIR}/lit-artifact-generator/index.js generate --force --vocabListFile ${SCRIPT_DIR}/**/*.yml --vocabListFileIgnore "${SCRIPT_DIR}/lit-artifact-generator/**" --noprompt --publish [ "localMaven", "localNpmNode" ]

# node ./lit-artifact-generator/index.js generate --vocabListFile **/*.yml --vocabListFileIgnore "lit-artifact-generator/**" --noprompt --publish [ "localMaven", "localNpmNode" ]
