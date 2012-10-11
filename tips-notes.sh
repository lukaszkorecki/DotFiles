# print git dependencies  and prepend * before 'em
grep ":git" Gemfile | cut -d '"'  -f 2  | xargs -I '#' echo '* ' \#

# remove git submodule module permanently
function git-rm-submodule() { git rm --cached $1 && rm -rf $1 }

