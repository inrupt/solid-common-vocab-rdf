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

source ./run_command.sh

# Get the directory this script itself is located in.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DEFAULT_TARGET_DIR="./src/ExternalVocab"
TARGET_DIR="${PWD}/${DEFAULT_TARGET_DIR}"

helpFunction() {
    printf "Usage: $0 [ -t <TargetDirectory to regenerate vocabulary source code> ]\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-t ${BLUE}Optional: target directory (default is: [${DEFAULT_TARGET_DIR}])${NORMAL}\n"
    printf "${BLUE}Executes the LIT Artifact Generator to watch all YAML files found from here.${NORMAL}\n"
    printf "${RED}Current working directory: [${PWD}]${NORMAL}\n"
    printf "${RED}Script directory: [${SCRIPT_DIR}]${NORMAL}\n\n"
}

while getopts ":o:" opt
do
    case "$opt" in
      t ) TARGET_DIR=$OPTARG ;;
      \? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done


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

run_command "${SCRIPT_DIR}/fetchLag.sh"

# We don't yet have globbing support for the WATCH feature...
#node lit-artifact-generator/index.js watch --vocabListFile **/*.yml --vocabListFileIgnore "lit-artifact-generator/**"

#
# This is how we watch a single YAML, and on changes generate to a local source
# folder within our project...
#
# (Assumes LAG is globally installed)
# (Assumes the external vocabs are local, i.e. '/home/pmcb55/Work/Projects/LIT/lit-vocab/')
#
#lit-artifact-generator watch \
#  --vocabListFile /home/pmcb55/Work/Projects/LIT/lit-vocab/inrupt-rdf-vocab/UiComponent/Vocab-List-Inrupt-UiComponent.yml \
#  --TARGET_DIR src/ExternalVocab/inrupt-ui-component/

node ${TARGET_DIR}/lit-artifact-generator/index.js watch \
  --vocabListFile /home/pmcb55/Work/Projects/LIT/lit-vocab/inrupt-rdf-vocab/UiComponent/Vocab-List-Inrupt-UiComponent.yml \
  --TARGET_DIR ${TARGET_DIR}/inrupt-lit-generated-vocab-ui-component
