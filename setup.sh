#!/usr/bin/env bash
export CURR_PATH=`pwd`
cd ~
echo Symlinking .vimrc and .vim
ln -s $CURR_PATH/.vimrc .vimrc
ln -s $CURR_PATH/ .vim

echo done
