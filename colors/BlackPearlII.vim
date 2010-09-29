" Vim color file
" Converted from Textmate theme Black Pearl II using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Black Pearl II"

hi Cursor  guifg=NONE guibg=#ffffff gui=NONE
hi Visual  guifg=NONE guibg=#242424 gui=NONE
hi CursorLine  guifg=NONE guibg=#0d0d0d gui=NONE
hi CursorColumn  guifg=NONE guibg=#0d0d0d gui=NONE
hi LineNr  guifg=#808080 guibg=#000000 gui=NONE
hi VertSplit  guifg=#303030 guibg=#303030 gui=NONE
hi MatchParen  guifg=#f8bb00 guibg=NONE gui=bold
hi StatusLine  guifg=#ffffff guibg=#303030 gui=bold
hi StatusLineNC  guifg=#ffffff guibg=#303030 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#242424 gui=NONE
hi IncSearch  guifg=NONE guibg=#523e00 gui=NONE
hi Search  guifg=NONE guibg=#523e00 gui=NONE
hi Directory  guifg=#66ccff guibg=NONE gui=NONE
hi Folded  guifg=#428bdd guibg=#000000 gui=NONE

hi Normal  guifg=#ffffff guibg=#000000 gui=NONE
hi Boolean  guifg=#80d500 guibg=NONE gui=bold
hi Character  guifg=#d0ff7e guibg=NONE gui=NONE
hi Comment  guifg=#428bdd guibg=NONE gui=italic
hi Conditional  guifg=#ff9d00 guibg=NONE gui=NONE
hi Constant  guifg=#d0ff7e guibg=NONE gui=NONE
hi Define  guifg=#f8bb00 guibg=NONE gui=bold
hi ErrorMsg  guifg=NONE guibg=#670000 gui=bold
hi WarningMsg  guifg=NONE guibg=#670000 gui=bold
hi Float  guifg=#eddd5a guibg=NONE gui=NONE
hi Function  guifg=#ffffff guibg=NONE gui=bold
hi Identifier  guifg=#80d500 guibg=NONE gui=NONE
hi Keyword  guifg=#f8bb00 guibg=NONE gui=bold
hi Label  guifg=#cc66ff guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#0d0d0d gui=NONE
hi Number  guifg=#eddd5a guibg=NONE gui=NONE
hi Operator  guifg=#ffffff guibg=NONE gui=bold
hi PreProc  guifg=#f8bb00 guibg=NONE gui=bold
hi Special  guifg=#ffffff guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#0d0d0d gui=NONE
hi Statement  guifg=#ff9d00 guibg=NONE gui=NONE
hi StorageClass  guifg=#80d500 guibg=NONE gui=NONE
hi String  guifg=#cc66ff guibg=NONE gui=NONE
hi Tag  guifg=#ffffff guibg=NONE gui=bold
hi Title  guifg=#ffffff guibg=NONE gui=bold
hi Todo  guifg=#428bdd guibg=NONE gui=inverse,bold,italic
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#ff9d00 guibg=NONE gui=NONE
hi rubyFunction  guifg=#ffffff guibg=NONE gui=bold
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#66ccff guibg=NONE gui=NONE
hi rubyConstant  guifg=#8aa6c1 guibg=NONE gui=bold
hi rubyStringDelimiter  guifg=#cc66ff guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=#8aa6c1 guibg=NONE gui=italic
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#f8bb00 guibg=NONE gui=bold
hi rubyGlobalVariable  guifg=#d0ff7e guibg=NONE gui=NONE
hi rubyRegexp  guifg=#ca4344 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#ca4344 guibg=NONE gui=NONE
hi rubyEscape  guifg=#d0ff7e guibg=NONE gui=NONE
hi rubyControl  guifg=#ff9d00 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#ffffff guibg=NONE gui=bold
hi rubyException  guifg=#f8bb00 guibg=NONE gui=bold
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#8aa6c1 guibg=NONE gui=bold
hi rubyRailsARAssociationMethod  guifg=#8aa6c1 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#8aa6c1 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#8aa6c1 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#8aa6c1 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#428bdd guibg=NONE gui=italic
hi erubyRailsMethod  guifg=#8aa6c1 guibg=NONE gui=NONE
hi htmlTag  guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag  guifg=NONE guibg=NONE gui=NONE
hi htmlTagName  guifg=NONE guibg=NONE gui=NONE
hi htmlArg  guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#d0ff7e guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#80d500 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#8aa6c1 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#ffffff guibg=NONE gui=bold
hi yamlAnchor  guifg=#d0ff7e guibg=NONE gui=NONE
hi yamlAlias  guifg=#d0ff7e guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#cc66ff guibg=NONE gui=NONE
hi cssURL  guifg=#8aa6c1 guibg=NONE gui=italic
hi cssFunctionName  guifg=#8aa6c1 guibg=NONE gui=NONE
hi cssColor  guifg=#66ccff guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#b53b3c guibg=NONE gui=bold
hi cssClassName  guifg=#b53b3c guibg=NONE gui=bold
hi cssValueLength  guifg=#eddd5a guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#8aa6c1 guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
