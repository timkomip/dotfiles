# Cheatsheet

## General

```sh
md # mkdir -p
```

## Git

```sh
# rebase
grbom # git rebase origin/main

# stash
gstp # git stash pop
gstp # git stash push

# pull
gl # git pull
gpr # git pull --rebase
gpra # git pull --rebase --autostash

# push
gp # git push
gpsup # git push -u origin $(git_current_branch)
gpf # git push --force-with-lease --force-if-includes
gpf! # git push --force

# restore
grs # git restore
grst # git restore --staged

# reset
gru # git reset --

# checkout
gco # git checkout
gcb # git checkout -b
gcB # git checkout -B
gcm # git checkout main
```
