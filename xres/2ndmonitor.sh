#!/usr/bin/env bash
if [[ -z "$(xrandr | grep 'DP-1 disconn')" ]] ; then
  # use 2nd monitor
  xrandr --output DP-1 --auto --right-of LVDS-2
  # ...and rotate it
  #  xrandr --output DP-1 --rotate left
fi

