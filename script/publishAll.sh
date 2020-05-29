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
DEFAULT_TARGET_DIR="src/ExternalVocab"
TARGET_DIR="${PWD}/${DEFAULT_TARGET_DIR}"
PUBLISH_LOCAL=false
PUBLISH_REMOTE=false

helpFunction() {
    printf "Usage: $0 [ -t <TargetDirectory> ] [ -l | -r ]\n"
    printf "${BLUE}Executes the LIT Artifact Generator to re-generate and publish artifacts from all YAML files found from here.${NORMAL}\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-t ${YELLOW}Optional: ${BLUE}Target directory (default is: [${TARGET_DIR}])${NORMAL}\n"
    printf "\t-l ${BLUE}Publish locally${NORMAL}\n"
    printf "\t-r ${BLUE}Publish remotely${NORMAL}\n\n"
}

while getopts ":t:lr" opt
do
    case "$opt" in
      t ) TARGET_DIR="$OPTARG" ;;
      l ) PUBLISH_LOCAL=true ;;
      r ) PUBLISH_REMOTE=true ;;
      ? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

if [ "${PUBLISH_LOCAL}" == false ] && [ "${PUBLISH_REMOTE}" == false ]
then
    printf "${RED}You *MUST* stipulate whether to publish locally (the -l option) or remotely (the -r option).${NORMAL}\n\n"
    helpFunction
    exit 1 # Exit script after printing help.
fi

${SCRIPT_DIR}/fetchLag.sh -t ${TARGET_DIR}


if [ "${PUBLISH_LOCAL}" == true ]
then
    printf "\n${BLUE}Executing the LIT Artifact Generator to re-generate and re-publish ${RED}(LOCALLY)${BLUE} artifacts from all YAML files found from [${SCRIPT_DIR}].${NORMAL}\n"
    node ${TARGET_DIR}/lit-artifact-generator/index.js generate --vocabListFile ${SCRIPT_DIR}/**/*.yml --vocabListFileIgnore "${SCRIPT_DIR}/${TARGET_DIR}/lit-artifact-generator/**" --outputDirectory ${TARGET_DIR}/Generated --noprompt --publish [ "localMaven", "localNpmNode" ]
else
    printf "\n${BLUE}Executing the LIT Artifact Generator to re-generate and re-publish ${RED}(REMOTELY)${BLUE} artifacts from all YAML files found from [${SCRIPT_DIR}].${NORMAL}\n"
#    node ${TARGET_DIR}/lit-artifact-generator/index.js generate --force --vocabListFile ${SCRIPT_DIR}/**/*.yml --vocabListFileIgnore "${SCRIPT_DIR}/${TARGET_DIR}/lit-artifact-generator/**" --outputDirectory ${TARGET_DIR}/Generated --noprompt --publish [ "npm" ]
    node ${TARGET_DIR}/lit-artifact-generator/index.js generate --force --vocabListFile ${SCRIPT_DIR}/**/*.yml --vocabListFileIgnore "${SCRIPT_DIR}/${TARGET_DIR}/lit-artifact-generator/**" --outputDirectory ${TARGET_DIR}/Generated --noprompt
fi
#
# node ./lit-artifact-generator/index.js generate --vocabListFile **/*.yml --vocabListFileIgnore "lit-artifact-generator/**" --noprompt --publish [ "localMaven", "localNpmNode" ]
