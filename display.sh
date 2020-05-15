#!/bin/bash
# set -e to exit on error.
set -e
# set -u to error on unbound variable (use ${var:-} to check if 'var' is set.
set -u
set -o pipefail

helpFunction() {
    echo ""
    echo "Usage: $0 [ -a -b -c -d -e ]"
    echo -e "\t-a LIT Artifact Generator versions"
    echo -e "\t-b LIT Vocab Term Java versions"
    echo -e "\t-c Generated artifact Java versions"
    echo -e "\t-d LIT Vocab Term JavaScript versions"
    echo -e "\t-e Generated artifact JavaScript versions"
    echo ""
}

while getopts "abcde" opt
do
    case "$opt" in
      a ) litArtifactGenerator=true ;;
      b ) litVocabTermJava=true ;;
      c ) artifactJava=true ;;
      d ) litVocabTermJavaScript=true ;;
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
    command="grep -r \"artifactGeneratorVersion:\" --include=*.{yml,yaml}"
    printf "LIT Artifact Generator:\n"
    echo $command | bash | sed 's/\s*artifactGeneratorVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${litVocabTermJava:-}" ]
then
    # Java LIT Vocab Term versions.
    command="grep -r \"litVocabTermVersion:\s*[0-9]\" --include=*.{yml,yaml}"
    printf "Java LIT Vocab Term:\n"
    echo $command | bash | sed 's/\s*litVocabTermVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${artifactJava:-}" ]
then
    # Java artifact versions.
    command="grep -r \"artifactVersion:\s*[0-9]\" --include=*.{yml,yaml}"
    printf "Java artifacts:\n"
    echo $command | bash | sed 's/\s*artifactVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${litVocabTermJavaScript:-}" ]
then
    # JavaScript LIT Vocab Term versions.
    command="grep -r \"litVocabTermVersion:\s*\\\"\^\" --include=*.{yml,yaml}"
    printf "JavaScript LIT Vocab Term:\n"
    echo $command | bash | sed 's/\s*litVocabTermVersion: //' | column -s ':' -t
    echo ""
fi

if [ "${artifactJavaScript:-}" ]
then
    # JavaScript artifact versions.
    command="grep -r \"artifactVersion:\s*\\\"\" --include=*.{yml,yaml}"
    printf "JavaScript artifacts:\n"
    echo $command | bash | sed 's/\s*artifactVersion: //' | column -s ':' -t
    echo ""
fi
