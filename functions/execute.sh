#!/bin/bash

# execute $COMMAND [$ALT_TEXT] [$FLAG_DRYRUN=false]
# if command and FLAG_DRYRUN=true are set the command will be execuded
# if command and FLAG_DRYRUN=false (or no 3rd argument is provided) 
# if an ALT_TEXT is provided it will print the alt text instead of the command
# this can be used to mask sensitiv information
# the function will only print the command the command to stdout
function execute () {
  local exec_command=$1
  local alt_text=${2:-${1}}
  local flag_dryrun=${3:-$FLAG_DRYRUN}

  if [[ "${flag_dryrun}" == false ]]; then
    echo "+ ${alt_text}" | sed 's/  */ /g'
    eval "${exec_command}"
  else
    echo "${exec_command}" | sed 's/  */ /g'
  fi
}
# readonly definition of a function throws an error if another function 
# with the same name is defined a second time
readonly -f execute
[ "$?" -eq "0" ] || return $?

# Dependend functions
# docker_login