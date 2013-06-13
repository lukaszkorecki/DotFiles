LIST = vim vimrc irbrc pryrc tmux.conf rvmrc ackrc  gitconfig bashrc jshint.json

default: update

link: $(LIST)
	for f in $(LIST) ; do ln -s ~/.DotFiles/$$f ~/.$$f; done

unlink: $(LIST)
	@for f in $(LIST) ; do rm ~/.$$f; done

private:
	git clone git@bitbucket.org:lukaszkorecki/private-configs.git ~/.private || true

update:
	git submodule update --init
	- git pull --recurse-submodules --rebase
	git submodule foreach git reset --hard
	git submodule foreach git checkout master
	- git submodule foreach git pull --rebase

safe-update:
	git stash || make update || git stash pop
setup : link update private

tools:
	sudo apt-get install ctags tmux vim weechat
	sudo go get -u github.com/jstemmer/gotags
