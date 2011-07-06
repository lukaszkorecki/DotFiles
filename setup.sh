#!/usr/bin/env bash
echo Going home
cd ~

echo Cleaning up
rm -rf .vim
rm .vimrc

echo Cloning
git clone git://github.com/lukaszkorecki/VimConfig.git .vim

echo Symlinking .vimrc and
ln -s ~/.vim/.vimrc .vimrc

echo Getting submodules
cd .vim
git submodule init

git submodule update

echo DONE
