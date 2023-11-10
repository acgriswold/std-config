# Nah

_Nothing to see here..._

Simple phrase, but gets the point across. Remove and reset all local and git staged changes. Aborts any current rebase actions (i.e., apply and merge).

```bash
# Setup a simple global alias to reset any local and staged changes.
git config --global alias.nah '!git reset --hard; git clean -df; if [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then git rebase --abort; fi;'
git nah


# or run the script
bash ./nah.bashrc
```