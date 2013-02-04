#!/usr/bin/env bash
# ./remove-submodule name path-to-sm
echo Removing submodule: $1 from $2

echo Removed entries from .git configs
grep -v $1  .gitmodules > .gitmodules.2 && mv .gitmodules.2 .gitmodules
echo "gitmodules done"
grep -v $1  .git/config > .git/config.2 && mv .git/config.2 .git/config
echo ".git/config done"

echo "removing files"
git rm -r --cached $2
echo git files done
rm -r $2
echo untracked files done