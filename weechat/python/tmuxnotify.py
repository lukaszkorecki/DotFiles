# encoding: utf-8
# Author: Lukasz Korecki <lukasz at coffeesounds dot com
# Homepage: https://github.com/lukaszkorecki/DotFiles/blob/master/weechat/python/tmuxnotify.py

# Version: 0.1
#
# Requires Weechat 0.3
# Released under GNU GPL v2
#
# Copy weechaticn.png to /usr/local/share/pixmaps/ or change the path below
#
# Based (roughly) on http://github.com/tobypadilla/gnotify
# gnotify is derived from notify http://www.weechat.org/files/scripts/notify.py
# Original author: lavaramano <lavaramano AT gmail DOT com>

import weechat,  string, os

weechat.register("tmuxnotify", "lukaszkorecki", "0.1", "GPL", "tmux-notify: weechat notifications in tmux", "", "")

# script options
settings = {
		"show_hilights"             : "on",
		"show_priv_msg"             : "on",
		}


for option, default_value in settings.items():
	if weechat.config_get_plugin(option) == "":
		weechat.config_set_plugin(option, default_value)


# Hook privmsg/hilights
weechat.hook_signal("weechat_pv", "notify_show_priv", "")
weechat.hook_signal("weechat_highlight", "notify_show_hi", "")

# Functions
def notify_show_hi( data, signal, message ):
	"""Sends highlight message to be printed on notification"""
	if weechat.config_get_plugin('show_hilights') == "on":
		show_notification("IRC Mention")
	return weechat.WEECHAT_RC_OK

def notify_show_priv( data, signal, message ):
	"""Sends private message to be printed on notification"""
	if weechat.config_get_plugin('show_priv_msg') == "on":
		show_notification("IRC Message")
	return weechat.WEECHAT_RC_OK

def show_notification(message):
	os.popen("tmux set display-time {0} && tmux display-message '{1}' &".format(5 * 1000, message ))
