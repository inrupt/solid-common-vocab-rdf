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
    printf "Usage: $0 [ -a -b -c -d -e ]\n"
    printf "\t-a ${BLUE}LIT Artifact Generator versions${NORMAL}\n"
    printf "\t-b ${BLUE}LIT Vocab Term Java versions${NORMAL}\n"
    printf "\t-c ${BLUE}LIT Vocab Term JavaScript versions${NORMAL}\n"
    printf "\t-d ${BLUE}Generated artifact Java versions${NORMAL}\n"
    printf "\t-e ${BLUE}Generated artifact JavaScript versions${NORMAL}\n\n"
}

while getopts "abcde" opt
do
    case "$opt" in
      a ) litArtifactGenerator=true ;;
      b ) litVocabTermJava=true ;;
      c ) litVocabTermJavaScript=true ;;
      d ) artifactJava=true ;;
      e ) artifactJavaScript=true ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
    esac
done

# Print helpFunction in case parameters are empty, but display everything.
if [ "${1:-}" == "" ]
then
    echo "No specific options - displaying all!";
    helpFunction

    litArtifactGenerator=true;
    litVocabTermJava=true;
    artifactJava=true;
    litVocabTermJavaScript=true;
    artifactJavaScript=true;
fi

if [ "${litArtifactGenerator:-}" ]
then
    # LIT Artifact Generator.
    # Alternative is to use 'find' first, but grep can handle what we need.
    #  command="find . -type f \( -name '*.yml' -o -name '*.yaml' \) -not -path \"*/Generated/*\" -exec grep \"artifactGeneratorVersion:\" {} +"
    command="grep -r \"artifactGeneratorVersion:\" --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}a) LIT Artifact Generator versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*artifactGeneratorVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${litVocabTermJava:-}" ]
then
    # Java LIT Vocab Term versions.
    command="grep -r \"litVocabTermVersion:\s*[0-9]\" --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}b) Java LIT Vocab Term versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*litVocabTermVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${litVocabTermJavaScript:-}" ]
then
    # JavaScript LIT Vocab Term versions.
    command="grep -r \"litVocabTermVersion:\s*\\\"\^\" --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}c) JavaScript LIT Vocab Term versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*litVocabTermVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${artifactJava:-}" ]
then
    # Java generated artifact versions.
    command="grep -r \"artifactVersion:\s*[0-9]\" --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}d) Java generated artifact versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*artifactVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${artifactJavaScript:-}" ]
then
    # JavaScript generated artifact versions.
    command="grep -r \"artifactVersion:\s*\\\"\" --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}e) JavaScript generated artifact versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*artifactVersion: //' | column -s ':' -t
    echo ""
fi
