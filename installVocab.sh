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

PROGRAMMING_LANGUAGE=JavaScript

source ${SCRIPT_DIR}/run_command.sh

VOCAB_LOCAL=false
VOCAB_REMOTE=false

helpFunction() {
    echo ""
    printf "${YELLOW}Usage: $0 -r <RepositoryToClone> -m <VocabModule> [ -t <TargetDirectory> ] [ -p <ProgrammingLanguage> ] [ -l | -r ]\n"
    printf "Installs the provided vocabulary module locally (i.e. clones the module inside this project), or remotely (publishing any local changes).${NORMAL}\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-r ${BLUE}Repository to clone (e.g. git@github.com:inrupt/lit-vocab.git)${NORMAL}\n\n"
    printf "\t-m ${BLUE}Module to extract (may contain a bundle of vocabularies, e.g. @inrupt/lit-generated-vocab-common)${NORMAL}\n"
    printf "\t-t ${BLUE}Optional: target directory (default is: [${DEFAULT_TARGET_DIR}])${NORMAL}\n"
    printf "\t-p ${BLUE}Optional: programming language (default is: [${PROGRAMMING_LANGUAGE}])${NORMAL}\n"
    printf "\t-l ${BLUE}Depend on module locally (e.g. to watch for changes)${NORMAL}\n"
    printf "\t-r ${BLUE}Depend on module remotely (e.g. publish local changes back)${NORMAL}\n\n"
    printf "${RED}Current working directory: [${PWD}]${NORMAL}\n"
    printf "${RED}Target directory: [${TARGET_DIR}]${NORMAL}\n"
    printf "${RED}Script directory: [${SCRIPT_DIR}]${NORMAL}\n"
}

while getopts ":r:m:t:p:lr" opt
do
    case "$opt" in
      r ) GIT_REPOSITORY_URL="$OPTARG" ;;
      m ) VOCAB_MODULE="$OPTARG" ;;
      t ) TARGET_DIRECTORY="$OPTARG" ;;
      p ) PROGRAMMING_LANGUAGE="$OPTARG" ;;
      l ) VOCAB_LOCAL=true ;;
      r ) VOCAB_REMOTE=true ;;
      ? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done


if [ "${1:-}" == "?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

# Print help in case parameters are empty, but display everything.
if [ "${VOCAB_MODULE:-}" == "" ] || ( [ "${VOCAB_LOCAL}" == false ] && [ "${VOCAB_REMOTE}" == false ] )
then
    printf "${RED}You *MUST* provide a Vocab module, and state either local or remote.${NORMAL}\n"
    helpFunction
    exit 1 # Exit script after printing help.
fi

# Check if the module we want to install is mentioned in our 'package.json' file
# already (so we can uninstall what's there first before installing it fresh).
if grep "\"${VOCAB_MODULE}\": " ${PWD}/package.json > /dev/null 2>&1;
then
    printf "${GREEN}Found vocab module [$VOCAB_MODULE] in local 'package.json' file.${NORMAL}\n"
    printf "${GREEN}Uninstalling [${VOCAB_MODULE}] from this project...${NORMAL}\n"

    run_command "npm uninstall ${VOCAB_MODULE}"
else
    printf "${GREEN}Vocab module [$VOCAB_MODULE] not found in local 'package.json' file, so no need to uninstall it first.${NORMAL}\n"
fi

# If a local install, then we need to fetch the LAG, then clone the repository
# containing the module we actually want, use the LAG to generate artifacts
# locally, and then NPM install the actual module we want referencing the
# locally generated copy.
if [ ${VOCAB_LOCAL} == true ]
then
    printf "\n${GREEN}Fetching LIT Artifact Generator into directory [${TARGET_DIR}]...${NORMAL}\n"
    run_command "${SCRIPT_DIR}/fetchLag.sh -t ${TARGET_DIR}"

    printf "\n${GREEN}Fetching vocabulary repository [${GIT_REPOSITORY_URL}] into directory [${TARGET_DIR}]...${NORMAL}\n"
    run_command "${SCRIPT_DIR}/fetchVocabRepo.sh -r ${GIT_REPOSITORY_URL} -t ${TARGET_DIR}"


    REPO_DIR="$(echo ${GIT_REPOSITORY_URL} | sed 's/^.*\///' | sed 's/\..*$//')"
    FULL_REPO_DIR="${TARGET_DIR}/${REPO_DIR}"
    GENERATED_DIR="${FULL_REPO_DIR}/GENERATED"

    printf "\n${GREEN}Generating source-code artifacts from Git repo [${REPO_DIR}] in directory [${FULL_REPO_DIR}] into [${GENERATED_DIR}]...${NORMAL}\n"
#    node /home/pmcb55/Work/Projects/LIT/lit-artifact-generator/index.js \
    node ${TARGET_DIR}/lit-artifact-generator/index.js \
      generate \
      --outputDirectory "${GENERATED_DIR}" \
      --vocabListFile "${FULL_REPO_DIR}/**/*.yml" \
      --vocabListFileIgnore "${FULL_REPO_DIR}/lit-artifact-generator/**" \
      --noprompt
#      --force # Don't force generation of all for just one vocab install!



    printf "\n\n\n${RED}VOCAB_MODULE is [${VOCAB_MODULE}]...${NORMAL}\n\n\n"

    VOCAB_MODULE_DIRECTORY="$(echo $VOCAB_MODULE | sed 's/@//g' | sed 's/\//-/g')"
    printf "\n\n\n${RED}VOCAB_MODULE_DIRECTORY is [${VOCAB_MODULE_DIRECTORY}]...${NORMAL}\n\n\n"


    VOCAB_MODULE="@inrupt/lit-generated-vocab-ui-component"
    VOCAB_BUNDLE="inrupt-rdf-vocab"
    VOCAB_SUBMODULE="UIComponent"

    INSTALL=${VOCAB_MODULE}@file://${GENERATED_DIR}/${VOCAB_MODULE_DIRECTORY}/${VOCAB_SUBMODULE}/Generated/SourceCodeArtifacts/${PROGRAMMING_LANGUAGE}
    printf "\n${GREEN}Installing [${GIT_REPOSITORY_URL}] referencing local directory [${TARGET_DIR}]...${NORMAL}\n"
    printf "\n\nINSTALL: [${INSTALL}]...${NORMAL}\n"

exit 1

else
    INSTALL=${VOCAB_MODULE}
    printf "\n${GREEN}Installing [${GIT_REPOSITORY_URL}] remotely...${NORMAL}\n"
fi

printf "${GREEN}Installing [${INSTALL}].${NORMAL}\n"
run_command "npm install ${INSTALL}"

if [ ${VOCAB_LOCAL} == true ]
then
    printf "\n${GREEN}Watching vocabulary bundles within directory [${TARGET_DIR}]...${NORMAL}\n"
    run_command "${SCRIPT_DIR}/watchAll.sh -t ${TARGET_DIR}"
fi
