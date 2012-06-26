LIST = vim vimrc zshrc zshenv irbrc pryrc tmux.conf rvmrc ackrc  tmuxinator
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

# weird things happened when I did
# brew install <t1> <t2> <t3> so this needs to be broken down
# into separate steps
tools:
	brew install git-extras
	brew install homebrew/dupes/vim
	brew install ctags --HEAD
	brew install tmux

setup : link update private tools
