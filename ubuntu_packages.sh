sudo apt-get install tmux \
                    vim \
                    mutt-patched \
                    i3 \
                    xfont-terminus \
                    console-terminus \
                    rxvt-unicode \
                    git-core \
                    build-essential \
                    virtualbox \
                    ruby-full \
                    feh \
                    curl \
                    excuberant-ctags


if [ -z $(which vagrant) ] ; then
  curl "http://files.vagrantup.com/packages/db8e7a9c79b23264da129f55cf8569167fc22415/vagrant_1.3.3_x86_64.deb" >  /tmp/vagrant.deb

  sudo dpkg -i /tmp/vagrant.deb && rm /tmp/vagrant.deb
fi

if [ -z $(which VboxHeadless) ] ; then
curl "http://download.virtualbox.org/virtualbox/4.2.12/virtualbox-4.2_4.2.12-84980~Ubuntu~quantal_amd64.deb" > /tmp/vbox.deb
fi

sudo dpkg -i /tmp/vbox.deb && rm /tmp/vbox.deb
