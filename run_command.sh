#!/bin/bash

# Run a command - if it fails, exit all execution and prints an error.
function run_command {
    local command="$1"
    echo "[EXEC] $command"
    $command
    if [ $? -ne 0 ] ; then
      echo "[ERROR] Failed to execute command: [$command], with exit code [$?]"
      exit $?
    fi
}

