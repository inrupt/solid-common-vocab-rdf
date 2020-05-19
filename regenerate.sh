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

helpFunction() {
    echo ""
    printf "Usage: $0\n"
    printf "${BLUE}Executes the LIT Artifact Generator to re-generate artifacts from all YAML files found from here.${NORMAL}\n"
}

helpFunction

node lit-artifact-generator-js/index.js generate --vocabListFile **/*.yml --vocabListFileIgnore "lit-artifact-generator-js/**" --noprompt --publish [ "localMaven", "localNpmNode" ]
