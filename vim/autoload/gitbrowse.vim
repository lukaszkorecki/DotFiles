" open a single line on github using git-browse
if exists("g:loaded_git_browse") || &cp
  "  finish
endif

let g:loaded_git_browse = 1

function! gitbrowse#GitBrowseFile()
  let _line = line('v')
  let _file = expand('%')
  exec "Git browse -r " . _line . " " . _file
endf

" open a range of lines on github using git-browse
function! gitbrowse#GitBrowseFileRange() range
  let _file = expand('%')
  let _range="-r".a:firstline.",".a:lastline
  exec "Git browse " . _range . " " . _file
endf
