# commit-crime

Hopefully this alias does not come up very often.. but may be necessary when working in legacy code. Commits all staged changes allowing you to skip precommit hooks (e.g., `linting`, `tests`, etc.).

```bash
git config --global alias.commit-crime "commit -n"
git commit-crime
```