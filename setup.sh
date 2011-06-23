#!/usr/bin/env bash
echo Moving from `pwd` to home
cd ~
echo Cloning
git clone git://github.com/lukaszkorecki/VimConfig.git .vim
echo Symlinking .vimrc and .vim
ln -s .vim/.vimrc .vimrc
echo done
