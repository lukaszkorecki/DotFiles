LIST = irbrc pryrc tmux.conf ackrc  gitconfig bashrc jshint.json ctags inputrc gitignore_global puppet-lint.rc

default: update

link: link_dotfiles link_special_dotfiles
unlink: unlink_dotfiles unlink_special_dotfiles

link_dotfiles: $(LIST)
	for f in $(LIST) ; do ln -fvs ~/.DotFiles/$$f ~/.$$f; done

unlink_dotfiles: $(LIST)
	@for f in $(LIST) ; do rm ~/.$$f; done


# Stuff which doesn't link directly to ~/.FILENAME
link_special_dotfiles: private
	mkdir -p ~/.ssh/
	ln -fvs ~/.private/ssh/config ~/.ssh/config

unlink_special_dotfiles:
	rm ~/.ssh/config

private:
	git clone git@bitbucket.org:lukaszkorecki/private-configs.git ~/.private || true

update:
	git pull -r -u origin master
	git submodule update --init
	git submodule foreach git reset --hard
	git submodule foreach git checkout master
	git submodule foreach git pull -r -u origin master

safe-update:
	git stash || make update || git stash pop
setup : link update private

emacs:
	git clone git@github.com:lukaszkorecki/cult-leader.git ~/.emacs.d
	cd ~/.emacs.d && make

vim:
	git clone git@github.com:lukaszkorecki/DotVim ~/.vim
	cd ~/.vim && make
