#!/usr/bin/env bash
screen="HDMI1"
main="LVDS1"

if [[ -z "$(xrandr | grep "$screen disconn")" ]] ; then
  # use 2nd monitor
  xrandr --output $screen --auto --left-of $main
fi
