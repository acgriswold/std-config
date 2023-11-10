#!/bin/bash

# init nah
git config --global alias.nah '!git reset --hard; git clean -df; if [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then git rebase --abort; fi;'

# init commit-crime
git config --global alias.commit-crime "commit -n"

# init amend
git config --global alias.amend "commit --amend --no-edit"

# init aliases
git config --global alias.aliases "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"