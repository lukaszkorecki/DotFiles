#!/usr/bin/env/bash
if [[ -n "$XAUTHORITY" ]] ; then
  xrdb -merge ~/.DotFiles/xres/solarized
  xrdb -merge ~/.Xresources
  setxkbmap -option ctrl:nocaps
fi
