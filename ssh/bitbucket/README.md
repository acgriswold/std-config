# ssh/bitbucket

The Secure Shell protocol (ssh) allows developers to create secure connections between devices and Bitbucket Cloud (and other machines).
Connections are authenticated using _public SSH keys,_ which derived from a _private SSH key_ (stored locally on the device).

## Prerequisites
Having ssh cli commands downloaded on the machine helps ensure the proper creation and security of both public/private SSH key pairs. 

### Download openssh-client
Download openssh-client for `Debian`, `Ubuntu`, `Linux Mint`, and other Debian-based distributions with the command below.

```bash
sudo apt update && sudo apt install openssh-client
```

_Check that OpenSSH has been successfully install_
```bash
ssh -V
```

### Setup SSH agent
Allow `git` to use your SSH key by setting up an SSH agent.

```bash
ps -auxc | grep ssh-agent
```

Start agent by running:

```bash
eval $(ssh-agent)
```

## Create SSH Key pair

```bash
# navigate to root directory
cd ~
# generate public/private key pair
ssh-keygen -t ed25519 -b 4096 -C "{username@emaildomain.com}" -f {ssh-key-name}
```

## Add key to the SSH agent

```bash 
ssh-add ~/{ssh-key-name} # add the specific file where your ssh key is located
```

## Provide Bitbucket Cloud with the public key

```bash
cat ~/{ssh-key-name}.pub | xclip # add the copied content to the SSH keys panel within your Personal Bitbucket settings.

ssh -T git@bitbucket.org # verify proper ssh authentication (can access Bitbucket using git)
```


## References

- (atlassian support)[https://support.atlassian.com/bitbucket-cloud/docs/set-up-personal-ssh-keys-on-linux/]