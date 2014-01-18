sudo apt-get install tmux \
  vim \
  mutt-patched \
  git-core \
  build-essential \
  ruby1.9 \
  ruby1.9-dev \
  curl \
  tmux

sudo apt-get instal "*ctags"

if [[ -n "$WITHX" ]] ; then
  sudo apt-get install tmux \
    volti \
    feh \
    i3 \
    nm-applet \
    xfont-terminus \
    console-terminus \
    rxvt-unicode
fi


if [[ -n "$WITHVAGRANT" ]] ; then
  curl "http://files.vagrantup.com/packages/db8e7a9c79b23264da129f55cf8569167fc22415/vagrant_1.3.3_x86_64.deb" >  /tmp/vagrant.deb

  sudo dpkg -i /tmp/vagrant.deb && rm /tmp/vagrant.deb

  if [ -z $(which VboxHeadless) ] ; then
    curl "http://download.virtualbox.org/virtualbox/4.2.12/virtualbox-4.2_4.2.12-84980~Ubuntu~quantal_amd64.deb" > /tmp/vbox.deb
    sudo dpkg -i /tmp/vbox.deb && rm /tmp/vbox.deb
  fi

fi
