## charmbracelet - freeze

Downloading freeze to automate capturing "code/output" from the cli. Generate PNGs, SVGs, and WebPs with a single line of code!

## Prerequisites

The only prerequisite you may need is to have a system that supports .bashrc files and to know what tar file to download.

*Don't know your system?  Run the command below.*

```bash
uname --kernel-name --kernel-release --machine # Linux 5.10.102.1-microsoft-standard-WSL2 x86_64
```

__*process can also be used with other tar files, not only freeze*__

## Setup

### Download tar file

```bash
mkdir ~/.scripts/freeze # generate destination
curl -L -o ~/.scripts/freeze/charm-freeze.tar.gz https://github.com/charmbracelet/freeze/releases/download/v0.1.6/freeze_0.1.6_Linux_x86_64.tar.gz # download file to location with name from url
tar -zxvf ~/.scripts/freeze/charm-freeze.tar.gz --directory ~/.scripts/freeze --strip-components 1 # decompress tar.gz file to destination (flatten by 1 level)
```

### Setup alias

```bash
echo "

# charmbracelet alias setup for charm cli components (https://charm.sh/)
alias freeze='~/.scripts/freeze/freeze'
" >> ~/.bashrc # echo new alias into .bashrc
```

### Check setup (reload shell first)

```bash
freeze --help # make sure everything was set up correctly

freeze ____.__ -c user -o ~/.screenshots/_____.{png,svg,webp} # alias for ~/.config/freeze/user.json & output to ~/.screenshots
```

### Configuration *(Optional)*

```bash
mkdir ~/.config/freeze
mkdir ~/.screenshots

echo '{
    "background": "#171717",
    "margin": [
        10,
        5,
        10,
        5
    ],
    "padding": [
        20,
        40,
        20,
        20
    ],
    "window": true,
    "width": 0,
    "height": 0,
    "config": "default",
    "theme": "catppuccin-mocha",
    "border": {
        "radius": 8,
        "width": 1,
        "color": "#515151"
    },
    "shadow": {
        "blur": 8,
        "x": 4,
        "y": 6
    },
    "font": {
        "family": "JetBrains Mono",
        "file": "",
        "size": 12,
        "ligatures": true
    },
    "line_height": 1.4,
    "line_numbers": true
}
' > ~/.config/freeze/user.json
```