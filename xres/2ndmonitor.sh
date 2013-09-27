#!/usr/bin/env bash
screen="DP2"
main="LVDS-2"

if [[ -z "$(xrandr | grep "$screen disconn")" ]] ; then
  # use 2nd monitor
  xrandr --output $screen --auto --right-of LVDS-2
  # ...and rotate it
  xrandr --output $screen --rotate left
fi
