# show only directories, ordered by modification date, latest at the bottom
ls -ltrd */

# print git dependencies  and prepend * before 'em
grep ":git" Gemfile | cut -d '"'  -f 2  | xargs -I '#' echo '* ' \#

# remove git submodule module permanently
function git-rm-submodule() { git rm --cached $1 && rm -rf $1 }

# get all :git gems and publish them to gem server
for d in $(grep :git ../dir/Gemfile | cut -f 2 -d " " | xargs echo | tr "," " " ) ; ./scripts/publish-gem ../$d -f

# extract  23953453 from lol/wut-the-hell-23953453/stuff/x.yaml if x.yml contains xxx
git grep xxx | grep "x.yaml" | cut -f 1 -d : | uniq | cut -d / -f 2 | rev | cut -d - -f1

# remove git submodule
name="module-nam"
git rm --cached <path to module>
grep -v $name .gitmodules > .gitmodules.2 && mv .gitmodules.2 .gitmodules
