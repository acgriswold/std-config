# git

Most basically is a distributed version control system. Developers use this to track changes
in any set of files to coordinate work and aid in collaboration between programmers.

## Simple actions

### Create new branch from remotes
```bash
git branch fetch # fetch latest changes
git checkout -b '<branch-name>' origin/HEAD && git branch --unset-upstream # create new branch based on remote branch origin/HEAD and remove unwanted upstream
```

### Delete multiple files
```bash
git branch | cut -c3- | grep -E '<regex-pattern>' | xargs git branch -D # delete all branches matching <regex-pattern>

# or

git branch --list '<regex-pattern>' | xargs git branch -D # delete all branches matching <regex-pattern>
```