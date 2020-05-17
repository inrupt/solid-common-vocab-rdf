#!/bin/bash

source ./run_command.sh

helpFunction()
{
    echo ""
    echo "Usage: $0 Feature label to checkout, e.g. $0 feat/latest-java-lit-vocab-term"
    exit 1 # Exit script after printing help
}


if [ "$1" == "" ]
then
    helpFunction
fi

printf "Fetching inrupt-rdf-vocab, and checking out: $1..."
run_command "cd inrupt-rdf-vocab/"
run_command "git checkout master"
run_command "git fetch"
run_command "git rebase origin/master"
run_command "git checkout -b $1"

printf "\nFetching lit-rdf-vocab, and checking out: $1..."
cd ..
run_command "cd lit-rdf-vocab/"
run_command "git checkout master"
run_command "git fetch"
run_command "git rebase origin/master"
run_command "git checkout -b $1"

printf "\nFetching solid-rdf-vocab, and checking out: $1..."
cd ..
run_command "cd solid-rdf-vocab/"
run_command "git checkout master"
run_command "git fetch"
run_command "git rebase origin/master"
run_command "git checkout -b $1"
