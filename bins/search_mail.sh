#!/bin/zsh
# Ghetto email address search, might be slow and error prone
# Installation:
# Make this script executable (as you can see it requires ZSH)
# Add this setting to your muttrc:
# set query_command="name='%s' <path_to_>/search_mail.sh"
#
# Usage
# create a new email/reply to someone
# press Ctrl+T
# boom
# ???
# profit
#
# No licence, use at your own risk
_dir=$(find ~/.mutt/cache/bodies/ -type d -name "*Inbox*")
echo Searching in $_dir
grep -h "^From: $name.*@" $_dir/*   | sed "s/From: //" | sort | uniq
