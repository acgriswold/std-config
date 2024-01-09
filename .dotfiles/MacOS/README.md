# MacOS .dotfiles

MacOS comes with some pre-setup shells and nice-to-haves when it comes to programming.  My setup extends this with minimal applications/ packages to keep things running smoothly.

## Applications

- `arc`: [Arc browser](https://arc.net/)
- `docker`: [Docker desktop](https://www.docker.com/products/docker-desktop/)
- `figma`: [Figma design application](https://www.figma.com/files/recents-and-sharing?fuid=600024511643714089)
- `VS code`: [Visual studio code](https://code.visualstudio.com/)
- `iTerm2`: [Terminal with configuration](https://iterm2.com/)

- `httpie`: [curl but better](https://httpie.io/)
- `orbstack`: [A fast, light, and easy way to run Docker containers and Linux](https://orbstack.dev/)

## Brews

- `parallel`: [Build and execute shell commands in parallel](https://savannah.gnu.org/projects/parallel/)
- `httpie`
- `python`
- `sqlite`

## Setting up a new machine with brew

```shell
# install brew onto new machine
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# download the Brewfile into the root directory and call this command to restore all taps
brew update 
brew update --file=~/Brewfile
```

### Setup httpie

```shell
brew install httpie

# or

# install the python package provided with homebrew
brew install python

# install HTTPie with the pip utility
pip install httpie

# add the shared python folder to your path
nano ~/.bash_profile

# Add the following line to your ~/.bash_profile
export PATH=/usr/local/share/python:$PATH
```

## Creating new Brewfile

```shell
brew bundle dump # --force
```