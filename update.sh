#!/bin/bash
# set -e to exit on error.
set -e
# set -u to error on unbound variable (use ${var:-} to check if 'var' is set).
set -u
set -o pipefail


helpFunction()
{
    echo ""
    echo "Usage: $0 -a <... version> -b <... version> -c <... version> -d <... version> -e <... version>"
    echo -e "\t-a LIT Artifact Generator version"
    echo -e "\t-b LIT Vocab Term Java version"
    echo -e "\t-c Generated artifact Java version"
    echo -e "\t-d LIT Vocab Term JavaScript version"
    echo -e "\t-e Generated artifact JavaScript version"
    exit 1 # Exit script after printing help
}

while getopts "a:b:c:d:e:" opt
do
    case "$opt" in
      a ) versionLitArtifactGenerator="$OPTARG" ;;
      b ) versionLitVocabTermJava="$OPTARG" ;;
      c ) versionArtifactJava="$OPTARG" ;;
      d ) versionLitVocabTermJavaScript="$OPTARG" ;;
      e ) versionArtifactJavaScript="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
    esac
done

# Print helpFunction in case parameters are empty.
if [ "${1:-}" == "" ]
then
    echo "No version updates specified!";
    helpFunction
fi

if [ "${versionLitArtifactGenerator:-}" ]
then
    # LIT Artifact Generator versions.
    printf "Updating LIT Artifact Generator to version: [$versionLitArtifactGenerator].\n"
#    sed --in-place "s/artifactGeneratorVersion:\s*.*/artifactGeneratorVersion: $versionLitArtifactGenerator/" **/*.yml
    find . -type f -name "*.yml" -print0 | xargs -0 sed --in-place "s/artifactGeneratorVersion:\s*.*/artifactGeneratorVersion: $versionLitArtifactGenerator/"
fi

if [ "${versionLitVocabTermJava:-}" ]
then
    # Java LIT Vocab Term versions.
    printf "\nUpdating Java LIT Vocab Term to version: [$versionLitVocabTermJava.\n"
    find . -type f -name "*.yml" -print0 | xargs -0 sed --in-place "s/litVocabTermVersion:\s*[0-9].*/litVocabTermVersion: $versionLitVocabTermJava/"
fi

if [ "${versionArtifactJava:-}" ]
then
    # Java generated artifact versions.
    printf "\nUpdating Java generated artifacts to version: [$versionArtifactJava].\n"
    find . -type f -name "*.yml" -print0 | xargs -0 sed --in-place "s/artifactVersion:\s*[0-9].*/artifactVersion: $versionArtifactJava/"
fi

if [ "${versionLitVocabTermJavaScript:-}" ]
then
    # JavaScript LIT Vocab Term versions.
    printf "\nUpdating JavaScript LIT Vocab Term to version: [$versionLitVocabTermJavaScript].\n"
    find . -type f -name "*.yml" -print0 | xargs -0 sed --in-place "s/litVocabTermVersion:\s*\\\"\^.*/litVocabTermVersion: \\\"\^$versionLitVocabTermJavaScript\"/"
fi

if [ "${versionArtifactJavaScript:-}" ]
then
    # JavaScript generated artifact versions.
    printf "\nUpdating JavaScript generated artifacts to version: [$versionArtifactJavaScript].\n"
    find . -type f -name "*.yml" -print0 | xargs -0 sed --in-place "s/artifactVersion:\s*\\\".*/artifactVersion: \\\"\^$versionArtifactJavaScript\"/"
fi

printf "\nUpdated YAML files:\n\n"

# We can't pass all our arguments (e.g. "$@"), because display script will barf
# on our version values. But just use conditional checks to only pass if bound.
./display.sh "${1:-}" "${3:-}" "${5:-}" "${7:-}" "${9:-}"
