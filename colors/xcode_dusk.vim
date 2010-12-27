" Vim color file
" Converted from Textmate theme Xcode Dusk using Coloration v0.2.5 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Xcode Dusk"

hi Cursor  guifg=NONE guibg=#ffffff gui=NONE
hi Visual  guifg=NONE guibg=#7f7f61 gui=NONE
hi CursorLine  guifg=NONE guibg=#1c1e25 gui=NONE
hi CursorColumn  guifg=NONE guibg=#1c1e25 gui=NONE
hi LineNr  guifg=#8f9093 guibg=#1e2028 gui=NONE
hi VertSplit  guifg=#494a51 guibg=#494a51 gui=NONE
hi MatchParen  guifg=#861b89 guibg=NONE gui=NONE
hi StatusLine  guifg=#ffffff guibg=#494a51 gui=bold
hi StatusLineNC  guifg=#ffffff guibg=#494a51 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#7f7f61 gui=NONE
hi IncSearch  guifg=NONE guibg=#401e48 gui=NONE
hi Search  guifg=NONE guibg=#401e48 gui=NONE
hi Directory  guifg=#55747d guibg=NONE gui=NONE
hi Folded  guifg=#41b645 guibg=#1e2028 gui=NONE

hi Normal  guifg=#ffffff guibg=#1e2028 gui=NONE
hi Boolean  guifg=#b21988 guibg=NONE gui=NONE
hi Character  guifg=#55747d guibg=NONE gui=NONE
hi Comment  guifg=#41b645 guibg=NONE gui=NONE
hi Conditional  guifg=#861b89 guibg=NONE gui=NONE
hi Constant  guifg=NONE guibg=NONE gui=NONE
hi Define  guifg=#861b89 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=NONE gui=NONE
hi WarningMsg  guifg=#ffffff guibg=NONE gui=NONE
hi Float  guifg=#1a19d1 guibg=NONE gui=NONE
hi Function  guifg=#ffffff guibg=NONE gui=NONE
hi Identifier  guifg=#b21988 guibg=NONE gui=NONE
hi Keyword  guifg=#861b89 guibg=NONE gui=NONE
hi Label  guifg=#db2b38 guibg=NONE gui=NONE
hi NonText  guifg=#bfbfbf guibg=#1c1e25 gui=NONE
hi Number  guifg=#1a19d1 guibg=NONE gui=NONE
hi Operator  guifg=#861b89 guibg=NONE gui=NONE
hi PreProc  guifg=#861b89 guibg=NONE gui=NONE
hi Special  guifg=#ffffff guibg=NONE gui=NONE
hi SpecialKey  guifg=#bfbfbf guibg=#1c1e25 gui=NONE
hi Statement  guifg=#861b89 guibg=NONE gui=NONE
hi StorageClass  guifg=#b21988 guibg=NONE gui=NONE
hi String  guifg=#db2b38 guibg=NONE gui=NONE
hi Tag  guifg=#790ead guibg=NONE gui=NONE
hi Title  guifg=#ffffff guibg=NONE gui=bold
hi Todo  guifg=#41b645 guibg=NONE gui=inverse,bold
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#861b89 guibg=NONE gui=NONE
hi rubyFunction  guifg=#ffffff guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#55747d guibg=NONE gui=NONE
hi rubyConstant  guifg=#029fbf guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#db2b38 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=#ffffff guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#ffffff guibg=NONE gui=NONE
hi rubyInclude  guifg=#861b89 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#ffffff guibg=NONE gui=NONE
hi rubyRegexp  guifg=#db2b38 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#db2b38 guibg=NONE gui=NONE
hi rubyEscape  guifg=#55747d guibg=NONE gui=NONE
hi rubyControl  guifg=#861b89 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#861b89 guibg=NONE gui=NONE
hi rubyException  guifg=#861b89 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#ffffff guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#029fbf guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#029fbf guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#029fbf guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#029fbf guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#029fbf guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#41b645 guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=#029fbf guibg=NONE gui=NONE
hi htmlTag  guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag  guifg=NONE guibg=NONE gui=NONE
hi htmlTagName  guifg=NONE guibg=NONE gui=NONE
hi htmlArg  guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#55747d guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#b21988 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#029fbf guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#790ead guibg=NONE gui=NONE
hi yamlAnchor  guifg=#ffffff guibg=NONE gui=NONE
hi yamlAlias  guifg=#ffffff guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#db2b38 guibg=NONE gui=NONE
hi cssURL  guifg=#ffffff guibg=NONE gui=NONE
hi cssFunctionName  guifg=#029fbf guibg=NONE gui=NONE
hi cssColor  guifg=#55747d guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#029fbf guibg=NONE gui=NONE
hi cssClassName  guifg=#029fbf guibg=NONE gui=NONE
hi cssValueLength  guifg=#1a19d1 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#029fbf guibg=#1e2028 gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
