# ssh

The Secure Shell protocol (ssh) allows developers to create secure connections between devices and Bitbucket Cloud (and other machines).

Connections are authenticated using _public SSH keys_, which derived from a _private SSH key_ (stored locally on the device).


# key-manager.sh

Generate key automates generating/assigning keys and verifying a working ssh-agent

```bash
bash key-manager.sh -k {key} # with default user
bash key-manager.sh -u {user} -k {key}
```


## Optional

**Setup bash alias inside `~/.bashrc`**

```bash
echo "

# Simple SSH key manager for generating and assigning ssh keys
alias km='. ~/.ssh/key-manager.sh'
"
```


## Help

```bash
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
  echo " bb, bitbucket      Setup Bitbucket ssh keys"
```

### Add simple quick action

Inside of the handle_options() method, handle your new option to the switch statement

```bash
# example option handling
# ...
    gh | github*)
      setup_agent
      keyname="github"
      ;;
# ...
```

__*remember to update the usage() method*__