" open a single line on github using git-surf
if exists("g:loaded_git_surf") || &cp
  "  finish
endif

let g:loaded_git_surf= 1

function! gitsurf#File()
  let _line = line('v')
  let _file = expand('%')
  exec "Git surf -r " . _line . " " . _file
endf

" open a range of lines on github using git-surf
function! gitsurf#FileRange() range
  let _file = expand('%')
  let _range="-r".a:firstline.",".a:lastline
  exec "Git surf " . _range . " " . _file
endf
