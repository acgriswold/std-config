#!/bin/bash
# PREREQ: echo $SSH_AGENT_PID   or   ps -auxc | grep ssh-agent   then   eval $(ssh-agent)
# RUN WITH bash ~/.ssh/keys/key-manager.sh -k {key name} -u {user name} -s

setupAgent=false
user="agriswold@hntb.com"
key=""

handle_error() {
  usage
  kill_agent
  exit 1
}

handle_success() {
  exit 1
}

kill_agent() {
  if [ $setupAgent = true ] && [ "$SSH_AGENT_PID" != "" ]; then
    eval `ssh-agent -k`
  fi
}

print_branding() {
  echo " _____  _____  _____    _____                               "
  echo "|   __||   __||  |  |  |     | ___  ___  ___  ___  ___  ___ "
  echo "|__   ||__   ||     |  | | | || .'||   || .'|| . || -_||  _|"
  echo "|_____||_____||__|__|  |_|_|_||__,||_|_||__,||_  ||___||_|  "
  echo "                                             |___|          "
  echo "                                                            "


  # echo ' ______   ______   __  __       __    __   ______   __   __   ______   ______   ______   ______    '
  # echo '/\  ___\ /\  ___\ /\ \_\ \     /\ "-./  \ /\  __ \ /\ "-.\ \ /\  __ \ /\  ___\ /\  ___\ /\  == \   '
  # echo '\ \___  \\ \___  \\ \  __ \    \ \ \-./\ \\ \  __ \\ \ \-.  \\ \  __ \\ \ \__ \\ \  __\ \ \  __<   '
  # echo ' \/\_____\\/\_____\\ \_\ \_\    \ \_\ \ \_\\ \_\ \_\\ \_\\"\_\\ \_\ \_\\ \_____\\ \_____\\ \_\ \_\ '
  # echo '  \/_____/ \/_____/ \/_/\/_/     \/_/  \/_/ \/_/\/_/ \/_/ \/_/ \/_/\/_/ \/_____/ \/_____/ \/_/ /_/ '
  # echo '                                                                                                   '
}

# Function to display script usage
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo " -h, --help            Display this help message"
  echo " -u, --user            User to assign key to"
  echo " -k, --key             REQUIRED: Name of the generated key (illegal characters will be removed)"
  echo " -l, --list            List currently registered keys"
  echo " -s, --setup           EXPERIMENTAL: Setup and configure ssh-agent for current shell session"
  echo "                                     Future expansions will try and pass in command to run after key is setup"

  if [ "$SSH_AGENT_PID" != "" ]; then
    echo ""
    echo "ssh-agent current setup up on process id $SSH_AGENT_PID"
  fi
}

has_argument() {
  [[ ("$1" == *=* && -n ${1#*=}) || (! -z "$2" && "$2" != -*) ]]
}

extract_argument() {
  echo "${2:-${1#*=}}"
}

# Function to handle options and arguments
handle_high_priority_options() {
  while [ $# -gt 0 ]; do
    case $1 in
    -s | --setup*)
      if [ "$SSH_AGENT_PID" = "" ]; then
        eval `ssh-agent -s`
        setupAgent=true
      else
        echo "ssh-agent already set up with id $SSH_AGENT_PID"
        setupAgent=false
      fi

      ;;
    esac
    shift
  done
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

      key="$HOME/.ssh/$(extract_argument $@ | sed -e 's/[^A-Za-z0-9._-]/_/g')"

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
    -l | --list*)
      ssh-add -l
      handle_success

      ;;
    -s | --setup*)
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
print_branding
handle_high_priority_options "$@"
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

# kill created ssh-agent to not leak processes
kill_agent