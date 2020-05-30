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
REPO_DIR=""
GENERATED_DIR="${TARGET_DIR}/Generated"

source ${SCRIPT_DIR}/run_command.sh

helpFunction() {
    printf "Usage: $0 [ -t <TargetDirectory for vocabulary source code> -r <RepositoryDirectory to watch> -g <GeneratedDirectory to generate source code into> ]\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-t ${YELLOW}Optional: ${BLUE}Target directory (default is: [${TARGET_DIR}])${NORMAL}\n"
    printf "\t-r ${YELLOW}Optional: ${BLUE}Repository directory (default is: [${REPO_DIR}])${NORMAL}\n"
    printf "\t-g ${YELLOW}Optional: ${BLUE}Generated directory (default is: [${GENERATED_DIR}])${NORMAL}\n"
    printf "${BLUE}Executes the LIT Artifact Generator to watch all RDF vocabularies referenced in all the YAML files found within the RepositoryDirectory inside the TargetDirectory, and generate source-code into the GeneratedDirectory.${NORMAL}\n"
    printf "${YELLOW}Current working directory: [${PWD}]${NORMAL}\n"
    printf "${YELLOW}Script directory: [${SCRIPT_DIR}]${NORMAL}\n\n"
    printf "${RED}Current working directory: [${PWD}]${NORMAL}\n"
    printf "${RED}Target directory: [${TARGET_DIR}]${NORMAL}\n"
    printf "${RED}Script directory: [${SCRIPT_DIR}]${NORMAL}\n"
}

while getopts ":t:r:g:" opt
do
    case "$opt" in
      t ) TARGET_DIR=$OPTARG ;;
      r ) REPO_DIR=$OPTARG ;;
      g ) GENERATED_DIR=$OPTARG ;;
      \? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

#run_command "${SCRIPT_DIR}/fetchLag.sh"

node ${TARGET_DIR}/lit-artifact-generator/index.js watch --vocabListFile ${TARGET_DIR}/${REPO_DIR}/**/*.yml --outputDirectory ${GENERATED_DIR}
