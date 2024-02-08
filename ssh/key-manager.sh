#!/bin/bash
# PREREQ: echo $SSH_AGENT_PID   or   ps -auxc | grep ssh-agent   then   eval $(ssh-agent)
# RUN WITH bash ~/.ssh/key-manager.sh -k {key name} -u {user name}

handle_error() {
  usage
  exit 1
}

user="{default user}"
key=""

# Function to display script usage
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo " -h, --help            Display this help message"
  echo " -u, --user            User to assign key to"
  echo " -k, --key             REQUIRED: Name of the generated key (illegal characters will be removed)"
}

has_argument() {
  [[ ("$1" == *=* && -n ${1#*=}) || (! -z "$2" && "$2" != -*) ]]
}

extract_argument() {
  echo "${2:-${1#*=}}"
}

# Function to handle options and arguments
handle_options() {
  while [ $# -gt 0 ]; do
    case $1 in
    -h | --help)
      usage
      exit 0
      ;;
    -v | --verbose)
      verbose_mode=true
      ;;
    -k | --key*)
      if ! has_argument $@; then
        echo "-n must be set to a valid key name" >&2
        handle_error
      fi

      key="$HOME/.ssh/keys/$(extract_argument $@ | sed -e 's/[^A-Za-z0-9._-]/_/g')"

      shift
      ;;
    -u | --user*)
      if ! has_argument $@; then
        echo "-u must be set to a valid user" >&2
        handle_error
      fi

      user=$(extract_argument $@)

      shift
      ;;
    *)
      echo "Invalid option: $1" >&2
      handle_error
      ;;
    esac
    shift
  done
}

# Run code
handle_options "$@"

if [ -z "$key" ]; then
  echo "key must be set to a valid "
  handle_error
fi

if [ "$SSH_AGENT_PID" = "" ]; then
  echo "\$SSH_AGENT_PID is not set up correctly."
  handle_error
fi

if ! [ -f "$key" ]; then
  ssh-keygen -t ed25519 -b 4096 -C "$user" -f "$key"
else
  echo "Skipping generation since $key already exists"
fi

# setup ssh key for 1 hour
ssh-add -t 1h "$key"
 
if [ $? -eq 0 ]; then
  echo "SSH public/private key pairs successfully added"
else
  echo "Could not add key"
fi
