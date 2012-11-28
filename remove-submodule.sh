#!/usr/bin/env bash
# ./remove-submodule name path-to-sm
echo Removing $1 from $2
grep -v $1  .gitmodules > .gitmodules.2 && mv .gitmodules.2 .gitmodules
git rm -r --cached $2
rm -r $2
