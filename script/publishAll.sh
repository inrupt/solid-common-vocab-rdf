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

# Default LAG directory is in a sibling directory of this script's directory.
LAG_DIR="${SCRIPT_DIR}/../bin"

# Default vocabulary configuration root directory (e.g. from which we expect to
# crawl recursively for YAMLs that bundle multiple RDF vocabularies) is in a
# sibling directory of this script's directory.
VOCAB_CONFIG_DIR="${SCRIPT_DIR}/../vocab"

# This default target directory is assuming we are running this script from
# within an application from which we've been making local updates to RDF
# vocabularies that we've cloned into the same place.
DEFAULT_TARGET_DIR="src/ExternalVocab"
TARGET_DIR="${PWD}/${DEFAULT_TARGET_DIR}"

PUBLISH_LOCAL=false
PUBLISH_REMOTE=false

helpFunction() {
    printf "Usage: $0 [ -t <TargetDirectory> ] [ -g <GeneratorDirectory> ] [ -v <VocabConfigRootDirectory> ] [ -l | -r ]\n"
    printf "${BLUE}Executes the LIT Artifact Generator to re-generate and publish artifacts from all YAML files found from here.${NORMAL}\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-t ${YELLOW}Optional: ${BLUE}Target directory (default is: [${TARGET_DIR}])${NORMAL}\n"
    printf "\t-g ${YELLOW}Optional: ${BLUE}LIT Artifact Generator directory (default is: [${LAG_DIR}])${NORMAL}\n"
    printf "\t-v ${YELLOW}Optional: ${BLUE}Root directory to search for LAG YAML files (default is: [${VOCAB_CONFIG_DIR}])${NORMAL}\n"
    printf "\t-l ${BLUE}Publish locally${NORMAL}\n"
    printf "\t-r ${BLUE}Publish remotely${NORMAL}\n\n"
}

while getopts ":t:g:lr" opt
do
    case "$opt" in
      t ) TARGET_DIR="$OPTARG" ;;
      g ) LAG_DIR="$OPTARG" ;;
      l ) PUBLISH_LOCAL=true ;;
      r ) PUBLISH_REMOTE=true ;;
      ? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
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

# Make sure we have the latest LIT Artifact Generator.
${SCRIPT_DIR}/fetchLag.sh -t ${LAG_DIR}

if [ "${PUBLISH_LOCAL}" == true ]
then
    printf "\n${BLUE}Executing the LIT Artifact Generator to re-generate and re-publish ${RED}(LOCALLY)${BLUE} artifacts from all YAML files found from [${SCRIPT_DIR}].${NORMAL}\n"
    node ${LAG_DIR}/lit-artifact-generator/index.js generate --vocabListFile ${VOCAB_CONFIG_DIR}/**/*.yml --outputDirectory ${TARGET_DIR}/Generated --force --noprompt --publish [ "localMaven", "localNpmNode" ]
else
    printf "\n${BLUE}Executing the LIT Artifact Generator to re-generate and re-publish ${RED}(REMOTELY)${BLUE} artifacts from all YAML files found from [${SCRIPT_DIR}].${NORMAL}\n"
#    node ${LAG_DIR}/lit-artifact-generator/index.js generate --force --vocabListFile ${VOCAB_CONFIG_DIR}/**/*.yml --vocabListFileIgnore "${SCRIPT_DIR}/${TARGET_DIR}/lit-artifact-generator/**" --outputDirectory ${TARGET_DIR}/Generated --noprompt --publish [ "npm" ]
    node ${LAG_DIR}/lit-artifact-generator/index.js generate --vocabListFile ${VOCAB_CONFIG_DIR}/**/*.yml --outputDirectory ${TARGET_DIR}/Generated --force --noprompt --publish [ "nexus", "npm" ]
fi
