" Vim color file
"
" orange
"
" useful help screens & commands
" :syntax
" :he group-name
" :he highlight-groups
" :he cterm-colors
"
" useful online resource
" http://www.colorpicker.com

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
		syntax reset
    endif
endif

let g:colors_name="orange"

hi Normal	guibg=#F6F9FB guifg=#333333

" syntax highlighting
hi Comment	  guifg=#7F7F7F
hi Title		  guifg=#416B24
hi Underlined guifg=#20b0eF gui=none
hi Statement  guifg=#FC8F19 gui=bold
hi Operator	  guifg=#333333 gui=none
hi Type		  guifg=#FC8F19 gui=bold
hi PreProc    guifg=#984D4D
hi Constant	  guifg=#FC8F19 gui=none
hi String	  guifg=#93B300 guibg=#FEFEFE
hi Number     guifg=#D52525
hi Float		  guifg=#D52525
hi Identifier guifg=#A7CC02 gui=bold
hi Function	  guifg=#007777
hi StatusLine guifg=#FF0000
hi Special	  guifg=#333333

"ruby specific
hi rubyConstant guifg=#FC8F19 gui=none
hi rubyControl guifg=#FC8F19 gui=bold
hi rubyClass guifg=#FC8F19 gui=bold
hi rubyDefine guifg=#FC8F19 gui=bold
hi rubySymbol guifg=#93B300 gui=none

"php specific
hi phpVarSelector guifg=#A7CC02
hi phpClassDefine guifg=#007777 gui=none
"hi phpDefine guifg=#007777 gui=none
hi phpClCode guifg=#333333

"html specific


"highlight groups
hi Ignore	guifg=grey40
hi Todo		guifg=#204546 guibg=#FFBCFD
hi Cursor	 guibg=#5E7373 guifg=#F6F9FB
hi MatchParen guibg=#91c7c7 guifg=#F6F9FB
hi Directory guifg=#395420
hi DiffAdd guifg=#07AF07 guibg=#FFFFFF
hi DiffChange guifg=#333333 guibg=#FFFFFF
hi DiffDelete guifg=#FF0000 guibg=#FFFFFF
hi DiffText guifg=#000000 guibg=#FFE572
hi ErrorMsg guifg=#FFFFFF guibg=#0000FF
hi VertSplit	guibg=#555555 guifg=#A3FFFE gui=none
hi Folded	guibg=#7BD3D4 guifg=#2F2F2F
hi FoldColumn	guibg=#7BD3D4 guifg=#2F2F2F
hi LineNr   guifg=#2F2F2F guibg=#B8EAEB 
hi NonText  guifg=#52503B guibg=#D8D6BC
hi Search	guibg=#FDFF5B guifg=#52503B
hi IncSearch	guifg=#FDFF5B guibg=#52503B
hi StatusLine	guibg=#7BD3D4 guifg=#2F2F2F gui=none
hi StatusLineNC	guibg=#555555 guifg=#A3FFFE gui=none
hi Visual   guifg=#726F54 guibg=#D4FEFE
hi Pmenu	guifg=#52503B guibg=#FAAFFF
hi PmenuSel	guifg=#242318 guibg=#F375FB 
"vim: sw=4
