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
# Default directory to target is a sibling directory of where this script is.
TARGET_DIR="${SCRIPT_DIR}/../vocab"

helpFunction() {
    printf "${BLUE}Usage: $0 [ -t <TargetDirectory> ] [ -a <LAG versions> | -b <Java-LVT versions> | -c <JavaScript_LVT versions> | -d <Generated Java versions> | -e <Generated JavaScript versions> ]\n"
    printf "Displays version numbers being used across LIT Artifact Generator configuration files.${NORMAL}\n"
    printf "${RED}NOTE: Also displays version numbers from commented-out entries, which will be prefixed with a hash '#'.${NORMAL}\n\n"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-t ${YELLOW}Optional: ${BLUE}Target directory (default is: [${TARGET_DIR}])${NORMAL}\n"
    printf "\t-a ${BLUE}LIT Artifact Generator versions${NORMAL}\n"
    printf "\t-b ${BLUE}LIT Vocab Term Java versions${NORMAL}\n"
    printf "\t-c ${BLUE}LIT Vocab Term JavaScript versions${NORMAL}\n"
    printf "\t-d ${BLUE}Generated Java JAR versions${NORMAL}\n"
    printf "\t-e ${BLUE}Generated JavaScript NPM versions${NORMAL}\n\n"
}

while getopts ":t:abcde" opt
do
    case "$opt" in
      t ) TARGET_DIR="$OPTARG" ;;
      a ) litArtifactGenerator=true ;;
      b ) litVocabTermJava=true ;;
      c ) litVocabTermJavaScript=true ;;
      d ) artifactJava=true ;;
      e ) artifactJavaScript=true ;;
      ? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

# Print help in case parameters are empty, but display everything.
if [ "${1:-}" == "" ]
then
    echo "${RED}No specific options - displaying all!${NORMAL}";
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
    command="grep -r \"artifactGeneratorVersion:\" ${TARGET_DIR} --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}a) LIT Artifact Generator versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*artifactGeneratorVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${litVocabTermJava:-}" ]
then
    # Java LIT Vocab Term versions.
    command="grep -r \"litVocabTermVersion:\s*[0-9]\" ${TARGET_DIR} --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}b) Java LIT Vocab Term versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*litVocabTermVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${litVocabTermJavaScript:-}" ]
then
    # JavaScript LIT Vocab Term versions.
    command="grep -r \"litVocabTermVersion:\s*\\\"\^\" ${TARGET_DIR} --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}c) JavaScript LIT Vocab Term versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*litVocabTermVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${artifactJava:-}" ]
then
    # Java generated artifact versions.
    command="grep -r \"artifactVersion:\s*[0-9]\" ${TARGET_DIR} --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}d) Generated Java JAR versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*artifactVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${artifactJavaScript:-}" ]
then
    # JavaScript generated artifact versions.
    command="grep -r \"artifactVersion:\s*\\\"\" ${TARGET_DIR} --include=*.{yml,yaml} --exclude-dir={Generated,node_modules,.github}"
    printf "${RED}e) Generated JavaScript NPM versions:${NORMAL}\n"
    echo $command | bash | sed 's/\s*artifactVersion: //' | column -s ':' -t
    echo ""
fi
