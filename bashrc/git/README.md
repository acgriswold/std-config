# bashrc/git

Simple git auto completion to speed up productivity.

__Content can be found [here](https://github.com/git/git/blob/master/contrib/completion/git-completion.bash).__

## Setup

Download the source for git-completion.bash and then add a basic `test -f ~/.git-completion.bash && . $_` to enable git-completion by default.

__*then restart your shell session*__

```bash
# Download git-completion.bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Add default git-completion for shell
echo $'test -f ~/.git-completion.bash && . $_' >> ~/.bashrc
```
