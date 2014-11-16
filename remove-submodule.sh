# ./remove-submodule name path-to-sm
#!/usr/bin/env bash
if [[ $1 == "-h" ]] ; then
  echo "$(basename $0) <submodule name> <path to submodule>"
  exit 0
fi

if [[ -z "$1$2"  ]] ; then
  ./$(basename $0) -h
  exit 0
fi

echo Removing submodule: $1 from $2

echo Removed entries from .git configs
grep -iv $1  .gitmodules > .gitmodules.2 && mv .gitmodules.2 .gitmodules
echo "gitmodules done"
grep -iv $1  .git/config > .git/config.2 && mv .git/config.2 .git/config
echo ".git/config done"

echo "removing files"
git rm -fr --cached $2
echo git files done
rm -r $2
echo untracked files done
