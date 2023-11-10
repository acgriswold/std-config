# Aliases

If you ever forget what aliases are available, `git aliases` is a great addition. Lists out all available git aliases with name and the function associated to them.

```bash
git config --global alias.aliases "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
git aliases
```