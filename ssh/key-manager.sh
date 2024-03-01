#!/bin/bash
# PREREQ: echo $SSH_AGENT_PID   or   ps -auxc | grep ssh-agent   then   eval $(ssh-agent)
#   or use -s flag
# RUN WITH . ~/.ssh/keys/key-manager.sh -k {key name} -u {user name} -s
# ALWAYS KEEP -s AT THE END OF THE SCRIPT UNTIL I FIGURE OUT A BETTER SOLUTION FOR FLAGS

shouldReturn=false

user=""
keyname=""
key=""

handle_error() {
  usage
  shouldReturn=true
}

handle_success() {
  shouldReturn=true
}

unset_values() {
  unset "user"
  unset "key"
  unset "keyname"
  unset "shouldReturn"
}

kill_agent() {
  if [ "$SSH_AGENT_PID" != "" ]; then
    eval "$(ssh-agent -k)"
  fi
}

setup_agent() {
  if [ "$SSH_AGENT_PID" = "" ]; then
    eval "$(ssh-agent -s)"
  else
    echo "ssh-agent already set up with id $SSH_AGENT_PID"
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
  echo " -s, --setup           Setup and configure ssh-agent for current shell session (be sure to source script to current shell to set all environment variables)"
  echo " -d, --drop-keys       Removes all keys from the current ssh-agent"
  echo " --kill                Kills the currently running ssh-agent"

  echo
  echo "Quick Actions:"
  echo " -bb, --bitbucket      Setup Bitbucket ssh keys"

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
      setup_agent

      ;;
    --kill*)
      kill_agent
      handle_success

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
      handle_success
      return
      ;;
    -v | --verbose)
      verbose_mode=true
      ;;
    -k | --key*)
      if ! has_argument $@; then
        echo "-k must be set to a valid key name" >&2
        handle_error
        return
      fi

      keyname=$(extract_argument $@)

      shift
      ;;
    -u | --user*)
      if ! has_argument $@; then
        echo "-u must be set to a valid user" >&2
        handle_error
        return
      fi

      user=$(extract_argument $@)

      shift
      ;;
    -l | --list*)
      ssh-add -l
      handle_success
      return

      ;;
    -d | --drop-keys*)
      ssh-add -D
      handle_success
      return

      ;;
    -bb | --bitbucket*)
      setup_agent
      keyname="bitbucket"
      ;;
    -s | --setup*) ;;
    *)
      echo "Invalid option: $1" >&2
      handle_error
      return
      ;;
    esac
    shift
  done
}

# Run code
print_branding
handle_high_priority_options "$@"

if [ $shouldReturn = true ]; then
  unset_values
  return 1
fi

handle_options "$@"
if [ $shouldReturn = true ]; then
  unset_values
  return 0
fi

# guard clauses ssh keys
if [ -z "$keyname" ]; then
  echo 'Key name must be provided'
  echo
  echo 'Run:'
  echo '    . key-manager.sh -k "myKey"'
  echo
  handle_error
  unset_values
  return 1
else
  key="$HOME/.ssh/$(echo "$keyname" | sed -e 's/[^A-Za-z0-9._-]/_/g')"
fi

if [ "$SSH_AGENT_PID" = "" ]; then
  echo "\$SSH_AGENT_PID is not set up correctly."
  handle_error
  unset_values
  return 1
fi

# default user to git config if non provided
if [ "$user" = "" ]; then
  user="$(git config --get user.email)"
fi

if [ "$user" = "" ]; then
  echo 'We use your git config as the default for our author identity'
  echo
  echo '*** Plase tell me who you are.'
  echo
  echo 'Run:'
  echo '    git config --global user.email "you@example.com"'
  echo
  echo 'Or provide the user flag:'
  echo '    . key-manager.sh -k "myKey" -u "you@example.com"'
  unset_values
  return 0
fi

# run code
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

handle_success
return 0
