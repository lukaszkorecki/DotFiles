### Thanks for checking out my dotfiles

> There's no place like ~/.DotFiles

## Back in the day

I've started with a lot of borrowed stuff from random forums and websites created around 1998.

Then I switched to oh-my-zsh.
Then I removed it.
Then I switched back to Bash.


## So

This repo is not a framework or anything.  I've been stripping down
the dependencies so that the configs and tweaks stay as small as possible.

Here's what you'll find here:

# `bins/`

I've written and accumulated a lot of scripts which help me with my
day-to-day tasks. Some are quite useful (`git-` extensions), some
are somewhat-useful (`fcrypt`) and some are just ridiculous (`faces`,
`imgcat`)

# `etc`

I've started creating boilerplate code templates interpolated with `m4`.
 There's not much stuff there, but there might be more soon.

### Usage

You can use tham like so:

```bash
USAGE='new cool tool' m4 ~/.DotFiles/etc/bash_skeleton.m4.sh
```

# `mutt`

Global configuration for mutt. Account specific configs are of
course not in this repo.

## The rest

The rest are of course configs for various pieces of software I use
every day.

# Vim? Emacs?

- My Vim configuration can be found at [lukaszkorecki/dotvim](https://github.com/lukaszkorecki/dotvim)

- My Emacs configuration can be found at [lukaszkorecki/cult-leader](https://github.com/lukaszkorecki/cult-leader)


# Supported OSs

85% of my time I'm working in a Linux VM (powered by
[lukaszkorecki/dev-machine](https://github.com/lukaszkorecki/dev-machine)
so it's guaranteed that these configs will work in Linux.

The other 15% is spent in OSX so I make sure stuff works there too.

# The Setup

### You'll need this:

- git
- make

### How To

```bash
    cd ~
    git clone git@github.com:lukaszkorecki/DotFiles.git .DotFiles # it HAS to be .DotFiles
    cd .DotFiles
    make setup
```


#### Tools

Here's a list of tools I can't work without:

- tmux (latest)
- Bash (4.1+)
- git
- vim

#### Programming languages I use

- Ruby
- Shell
- Javascript
- Go
- Python


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/lukaszkorecki/dotfiles/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
