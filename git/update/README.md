# update

Git alias to rebase and pull all current changes for the master branch (main,master,develop,etc.) when that main branch already has a few new commits.

_Keeping your local branch up to date will help avoid big merge conflicts._

```bash
# configures update to work with origin/main as the primary remote branch
git config --global alias.update "pull --rebase origin main"

# configures update to work with origin/master as the primary remote branch
git config --global alias.update-master "pull --rebase origin master"

# configures update to work with origin/develop as the primary remote branch
git config --global alias.update-develop "pull --rebase origin develop"
```