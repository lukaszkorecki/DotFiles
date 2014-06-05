#!/usr/bin/env bash
i3-msg workspace 1
i3-msg exec urxvt
sleep 0.3
i3-msg workspace 2
i3-msg exec google-chrome-beta
sleep 0.3
i3-msg workspace 1
