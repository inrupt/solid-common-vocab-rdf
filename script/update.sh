#!/bin/bash
# set -e to exit on error.
set -e
# set -u to error on unbound variable (use ${var:-} to check if 'var' is set).
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

helpFunction()
{
    echo ""
    echo "${BLUE}Usage: $0 [ -t <TargetDirectory> ] -a <... version> -b <... version> -c <... version> -d <... version> -e <... version>"
    printf "${BLUE}Options:${NORMAL}\n"
    printf "\t-t ${YELLOW}Optional: ${BLUE}Target directory (default is: [${TARGET_DIR}])${NORMAL}\n"
    printf "\t-a ${BLUE}LIT Artifact Generator versions${NORMAL}\n"
    printf "\t-b ${BLUE}LIT Vocab Term Java versions${NORMAL}\n"
    printf "\t-c ${BLUE}LIT Vocab Term JavaScript versions${NORMAL}\n"
    printf "\t-d ${BLUE}Generated Java JAR versions${NORMAL}\n"
    printf "\t-e ${BLUE}Generated JavaScript NPM versions${NORMAL}\n\n"
    exit 1 # Exit script after printing help
}

while getopts "a:b:c:d:e:" opt
do
    case "$opt" in
      a ) versionLitArtifactGenerator="$OPTARG" ;;
      b ) versionLitVocabTermJava="$OPTARG" ;;
      c ) versionLitVocabTermJavaScript="$OPTARG" ;;
      d ) versionArtifactJava="$OPTARG" ;;
      e ) versionArtifactJavaScript="$OPTARG" ;;
      ? ) helpFunction ;; # Print help in case parameter is non-existent
    esac
done

if [ "${1:-}" == "?" ] || [ "${1:-}" == "-?" ] || [ "${1:-}" == "-h" ] || [ "${1:-}" == "--help" ]
then
    helpFunction
    exit 1 # Exit script after printing help.
fi

# Print help in case parameters are empty.
if [ "${1:-}" == "" ]
then
    echo "${RED}No version updates specified!${NORMAL}";
    helpFunction
fi

if [ "${versionLitArtifactGenerator:-}" ]
then
    # LIT Artifact Generator versions.
    printf "\n${RED}a) Updating LIT Artifact Generator to version: [$versionLitArtifactGenerator]...${NORMAL}\n"
#    sed --in-place "s/artifactGeneratorVersion:\s*.*/artifactGeneratorVersion: $versionLitArtifactGenerator/" **/*.yml
    find ${TARGET_DIR} -type f \( -name '*.yml' -o -name '*.yaml' \) -not -path "*/Generated/*" -not -path "*/.github/*" -print0 | xargs -0 sed --in-place "s/artifactGeneratorVersion:\s*.*/artifactGeneratorVersion: $versionLitArtifactGenerator/"
fi

if [ "${versionLitVocabTermJava:-}" ]
then
    # Java LIT Vocab Term versions.
    printf "\n${RED}b) Updating Java LIT Vocab Term to version: [$versionLitVocabTermJava]...${NORMAL}\n"
    find ./vocab -type f \( -name '*.yml' -o -name '*.yaml' \) -not -path "*/Generated/*" -not -path "*/.github/*" -print0 | xargs -0 sed --in-place "s/litVocabTermVersion:\s*[0-9].*/litVocabTermVersion: $versionLitVocabTermJava/"
fi

if [ "${versionLitVocabTermJavaScript:-}" ]
then
    # JavaScript LIT Vocab Term versions.
    printf "\n${RED}c) Updating JavaScript LIT Vocab Term to version: [$versionLitVocabTermJavaScript]...${NORMAL}\n"
    find ./vocab -type f \( -name '*.yml' -o -name '*.yaml' \) -not -path "*/Generated/*" -not -path "*/.github/*" -print0 | xargs -0 sed --in-place "s/litVocabTermVersion:\s*\\\"\^.*/litVocabTermVersion: \\\"\^$versionLitVocabTermJavaScript\"/"
fi

if [ "${versionArtifactJava:-}" ]
then
    # Java generated artifact versions.
    printf "\n${RED}d) Updating Java generated artifacts to version: [$versionArtifactJava]...${NORMAL}\n"
    find ./vocab -type f \( -name '*.yml' -o -name '*.yaml' \) -not -path "*/Generated/*" -not -path "*/.github/*" -print0 | xargs -0 sed --in-place "s/artifactVersion:\s*[0-9].*/artifactVersion: $versionArtifactJava/"
fi

if [ "${versionArtifactJavaScript:-}" ]
then
    # JavaScript generated artifact versions.
    printf "\n${RED}e) Updating JavaScript generated artifacts to version: [$versionArtifactJavaScript]...${NORMAL}\n"
    find ./vocab -type f \( -name '*.yml' -o -name '*.yaml' \) -not -path "*/Generated/*" -not -path "*/.github/*" -print0 | xargs -0 sed --in-place "s/artifactVersion:\s*\\\".*/artifactVersion: \\\"$versionArtifactJavaScript\"/"
fi

printf "${GREEN}All YAML files updated!${NORMAL}\n\n"

# We can't pass all our arguments (e.g. "$@"), because display script will barf
# on our version values. But just use conditional checks to only pass if bound.
${SCRIPT_DIR}/display.sh "${1:-}" "${3:-}" "${5:-}" "${7:-}" "${9:-}"
