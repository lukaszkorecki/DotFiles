LIST = vim vimrc zshrc zshenv irbrc pryrc tmux.conf rvmrc ackrc  weechat gitconfig
link: $(LIST)
	for f in $(LIST) ; do ln -s ~/.DotFiles/$$f ~/.$$f; done
	ln -s ~/Dropbox/Work/irc.conf ~/.weechat/irc.conf

unlink: $(LIST)
	@for f in $(LIST) ; do rm ~/.$$f; done
	rm ~/.DotFiles/weechat/irc.conf

private:
	git clone git@bitbucket.org:lukaszkorecki/private-configs.git ~/.private

update:
	git submodule update --init
	- git pull --recurse-submodules --rebase
	git submodule foreach git reset --hard
	git submodule foreach git checkout master
	- git submodule foreach git pull --rebase
	git push
setup : link update private
