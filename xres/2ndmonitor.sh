screen="HDMI1"
#!/usr/bin/env bash
main="LVDS1"

if [[ -z "$(xrandr | grep "$screen disconn")" ]] ; then
  # use 2nd monitor
  xrandr --output $screen --auto --right-of $main
fi
