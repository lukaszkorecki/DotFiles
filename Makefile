LIST = irbrc pryrc tmux.conf ackrc  gitconfig bashrc jshint.json ctags inputrc gitignore_global puppet-lint.rc editorconfig

ROOT := ~/.DotFiles
PRIVATE_REPO := git@bitbucket.org:lukaszkorecki/private-configs.git

VIM_REPO := git@github.com:lukaszkorecki/DotVim.git
EMACS_REPO := git@github.com:lukaszkorecki/cult-leader.git

default: update

link: link_dotfiles link_special_dotfiles
unlink: unlink_dotfiles unlink_special_dotfiles

link_dotfiles:
	@for f in $(LIST) ; do ln -fvs $(ROOT)/$$f ~/.$$f; done

unlink_dotfiles:
	@for f in $(LIST) ; do rm ~/.$$f; done


# Stuff which doesn't link directly to ~/.FILENAME
link_special_dotfiles: private
	mkdir -p ~/.ssh/
	ln -fvs ~/.private/ssh/config ~/.ssh/config
	mkdir -p ~/.lein
	ln -fvs ~/.DotFiles/profiles.clj ~/.lein/profiles.clj

unlink_special_dotfiles:
	rm ~/.ssh/config
	rm ~/.lein/profiles.clj


private:
	git clone $(PRIVATE_REPO) ~/.private || true

update:
	git pull -r -u origin master
	git submodule update --init
	git submodule foreach git reset --hard
	git submodule foreach git checkout master
	git submodule foreach git pull -r -u origin master

setup: link update private vim

emacs:
	git clone $(EMACS_REPO) ~/.emacs.d
	cd ~/.emacs.d && make

vim:
	git clone $(VIM_REPO) ~/.vim
	cd ~/.vim && make
