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
    printf "${BLUE}Executes the LIT Artifact Generator to watch all YAML files found from here.${NORMAL}\n"
}

helpFunction

# We don't yet have globbing support for the WATCH feature...
#node lit-artifact-generator-js/index.js watch --vocabListFile **/*.yml --vocabListFileIgnore "lit-artifact-generator-js/**"

#
# This is how we watch a single YAML, and on changes generate to a local source
# folder within our project...
#
# (Assumes LAG is globally installed)
# (Assumes the external vocabs are local, i.e. '/home/pmcb55/Work/Projects/LIT/lit-vocab/')
#
#lit-artifact-generator-js watch \
#  --vocabListFile /home/pmcb55/Work/Projects/LIT/lit-vocab/inrupt-rdf-vocab/UiComponent/Vocab-List-Inrupt-UiComponent.yml \
#  --outputDirectory src/ExternalVocab/inrupt-ui-component/