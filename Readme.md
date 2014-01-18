Hi, it's cool that you're taking a look at my configs and such.
It's not a framework or anything and I've been stripping down the dependencies (for example oh-my-zsh, rake, vim plugins and others) so that the configs stay as small as possible.

If you want to use them though....

### You'll need this:

- git
- make

Here's a list of tools I can't work without:

- vim 7.3 (>7.1  is probably fine)
- tmux (latest)
- Bash

Programming languages I use on daily basis:

- Ruby
- Shell


### How to setup (once you got the stuff above)

    cd ~
    git clone git@github.com:lukaszkorecki/DotFiles.git .DotFiles # it HAS to be .DotFiles
    cd .DotFiles
    make setup

### Optional stuff

There is a `ubuntu_packages` script which installs other (essential) software such as Vim or i3


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/lukaszkorecki/dotfiles/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
