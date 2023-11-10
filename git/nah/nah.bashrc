# Bash function to abandon all current changes.
nah() {
    git reset --hard
    git clean -df
    if [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then 
        git rebase --abort
    fi
}