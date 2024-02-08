# ssh

The Secure Shell protocol (ssh) allows developers to create secure connections between devices and Bitbucket Cloud (and other machines).

Connections are authenticated using _public SSH keys_, which derived from a _private SSH key_ (stored locally on the device).


# generate-key.sh

Generate key automates generating/assigning keys and verifying a working ssh-agent

```bash
bash key-manager.sh -k {key} # with default user
bash key-manager.sh -u {user} -k {key}
```


## Optional

**Setup bash alias inside `~/.bashrc`**

```bash
alias {alias name}="bash ~/.ssh/key-manager.sh"


## THEN IN COMMAND LINE ##
source ~/.bashrc
```