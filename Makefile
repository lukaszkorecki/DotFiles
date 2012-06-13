LIST = vim vimrc zshrc irbrc pryrc tmux.conf rvmrc ackrc  tmuxinator
link: $(LIST)
	@for f in $(LIST) ; do ln -s ~/.DotFiles/$$f ~/.$$f; done

unlink: $(LIST)
	@for f in $(LIST) ; do rm ~/.$$f; done

private:
	git clone git@bitbucket.org:lukaszkorecki/private-configs.git ~/.private

update:
	git submodule update
	git submodule foreach git checkout master
	git pull --recurse-submodules

setup : link update private

