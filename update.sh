#!/usr/bin/env bash
echo Pulling changes
git pull

echo Updating submodules
git submodule init
git submodule update
git submodule foreach git pull origin master

echo Git Status
git status
