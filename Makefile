LIST = vim vimrc zshrc zshenv irbrc pryrc tmux.conf rvmrc ackrc  weechat
link: $(LIST)
	@for f in $(LIST) ; do ln -s ~/.DotFiles/$$f ~/.$$f; done

unlink: $(LIST)
	@for f in $(LIST) ; do rm ~/.$$f; done

private:
	git clone git@bitbucket.org:lukaszkorecki/private-configs.git ~/.private

update:
	git submodule update --init
	git pull --recurse-submodules --rebase
	git submodule foreach git reset --hard
	git submodule foreach git checkout master
	git submodule foreach git pull --rebase
	git push

# weird things happened when I did
# brew install <t1> <t2> <t3> so this needs to be broken down
# into separate steps
tools:
	brew install mutt
	brew install ctags --HEAD
	brew install tmux
	brew install colordiff
	brew install weechat
	brew install ack
	brew install reattach-to-user-namespace
	brew tap homebrew/dupes
	brew install homebrew/dupes/vim

setup : link update private tools
