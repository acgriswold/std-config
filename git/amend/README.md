# amend

Quick command and git alias to amend staged changes directly into the latest commit. Ignores opening vim to update the commit message.

```bash
git config --global alias.amend "commit --amend --no-edit"
```