" Vim color file
" Converted from Textmate theme Black Pearl using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Black Pearl"

hi Cursor  guifg=NONE guibg=#ffffff gui=NONE
hi Visual  guifg=NONE guibg=#242424 gui=NONE
hi CursorLine  guifg=NONE guibg=#0d0d0d gui=NONE
hi CursorColumn  guifg=NONE guibg=#0d0d0d gui=NONE
hi LineNr  guifg=#808080 guibg=#000000 gui=NONE
hi VertSplit  guifg=#303030 guibg=#303030 gui=NONE
hi MatchParen  guifg=#8aa6c1 guibg=NONE gui=NONE
hi StatusLine  guifg=#ffffff guibg=#303030 gui=bold
hi StatusLineNC  guifg=#ffffff guibg=#303030 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#242424 gui=NONE
hi IncSearch  guifg=NONE guibg=#2e3740 gui=NONE
hi Search  guifg=NONE guibg=#2e3740 gui=NONE
hi Directory  guifg=#80d500 guibg=NONE gui=NONE
hi Folded  guifg=#428bdd guibg=#000000 gui=NONE

hi Normal  guifg=#ffffff guibg=#000000 gui=NONE
hi Boolean  guifg=#8aa6c1 guibg=NONE gui=NONE
hi Character  guifg=#8aa6c1 guibg=NONE gui=NONE
hi Comment  guifg=#428bdd guibg=NONE gui=italic
hi Conditional  guifg=#f8bb00 guibg=NONE gui=NONE
hi Constant  guifg=#8aa6c1 guibg=NONE gui=NONE
hi Define  guifg=#8aa6c1 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=#670000 gui=NONE
hi WarningMsg  guifg=#ffffff guibg=#670000 gui=NONE
hi Float  guifg=#eddd5a guibg=NONE gui=NONE
hi Function  guifg=NONE guibg=NONE gui=NONE
hi Identifier  guifg=#80d500 guibg=NONE gui=NONE
hi Keyword  guifg=#8aa6c1 guibg=NONE gui=NONE
hi Label  guifg=#cc66ff guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#0d0d0d gui=NONE
hi Number  guifg=#eddd5a guibg=NONE gui=NONE
hi Operator  guifg=#ffffff guibg=NONE gui=bold
hi PreProc  guifg=#8aa6c1 guibg=NONE gui=NONE
hi Special  guifg=#ffffff guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#0d0d0d gui=NONE
hi Statement  guifg=#f8bb00 guibg=NONE gui=NONE
hi StorageClass  guifg=#80d500 guibg=NONE gui=NONE
hi String  guifg=#cc66ff guibg=NONE gui=NONE
hi Tag  guifg=#ffffff guibg=NONE gui=bold
hi Title  guifg=#ffffff guibg=NONE gui=bold
hi Todo  guifg=#428bdd guibg=NONE gui=inverse,bold,italic
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#f8bb00 guibg=NONE gui=NONE
hi rubyFunction  guifg=NONE guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#80d500 guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#cc66ff guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=#8aa6c1 guibg=NONE gui=italic
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#8aa6c1 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp  guifg=#ca4344 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#ca4344 guibg=NONE gui=NONE
hi rubyEscape  guifg=#8aa6c1 guibg=NONE gui=NONE
hi rubyControl  guifg=#f8bb00 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#ffffff guibg=NONE gui=bold
hi rubyException  guifg=#8aa6c1 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#428bdd guibg=NONE gui=italic
hi erubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi htmlTag  guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag  guifg=NONE guibg=NONE gui=NONE
hi htmlTagName  guifg=NONE guibg=NONE gui=NONE
hi htmlArg  guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#8aa6c1 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#80d500 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#ffffff guibg=NONE gui=bold
hi yamlAnchor  guifg=NONE guibg=NONE gui=NONE
hi yamlAlias  guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#cc66ff guibg=NONE gui=NONE
hi cssURL  guifg=#8aa6c1 guibg=NONE gui=italic
hi cssFunctionName  guifg=NONE guibg=NONE gui=NONE
hi cssColor  guifg=#80d500 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#b53b3c guibg=NONE gui=bold
hi cssClassName  guifg=#b53b3c guibg=NONE gui=bold
hi cssValueLength  guifg=#eddd5a guibg=NONE gui=NONE
hi cssCommonAttr  guifg=NONE guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
