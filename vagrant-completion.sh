if which vagrant ; then
  version=$(vagrant --version | cut -d' ' -f2)
  vagrantRoot=$(readlink $(which vagrant))
  cmpPath="$p/../../embedded/gems/gems/vagrant-$v/contrib/bash/completion.sh"

  source $cmpPath
fi
