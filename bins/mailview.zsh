#!/bin/zsh
# Open an html attachement in your browser of choice
# OSX only, but y'know... can be tweaked
local fn=/tmp/mail.$RANDOM.html
tee $fn && open $fn
