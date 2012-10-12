# show only directories, ordered by modification date, latest at the bottom
ls -ltrd */

# print git dependencies  and prepend * before 'em
grep ":git" Gemfile | cut -d '"'  -f 2  | xargs -I '#' echo '* ' \#

# remove git submodule module permanently
function git-rm-submodule() { git rm --cached $1 && rm -rf $1 }

# get all :git gems and publish them to gem server
for d in $(grep :git ../dir/Gemfile | cut -f 2 -d " " | xargs echo | tr "," " " ) ; ./scripts/publish-gem ../$d -f

