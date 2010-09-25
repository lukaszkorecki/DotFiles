" Vim color file
" Converted from Textmate theme Putty using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Putty"

hi Cursor  guifg=NONE guibg=#ffffff gui=NONE
hi Visual  guifg=NONE guibg=#535c72 gui=NONE
hi CursorLine  guifg=NONE guibg=#333435 gui=NONE
hi CursorColumn  guifg=NONE guibg=#333435 gui=NONE
hi LineNr  guifg=#85827f guibg=#242322 gui=NONE
hi VertSplit  guifg=#494745 guibg=#494745 gui=NONE
hi MatchParen  guifg=#e9eec2 guibg=NONE gui=NONE
hi StatusLine  guifg=#e5e1dc guibg=#494745 gui=bold
hi StatusLineNC  guifg=#e5e1dc guibg=#494745 gui=NONE
hi Pmenu  guifg=#ffffff guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#535c72 gui=NONE
hi IncSearch  guifg=NONE guibg=#656657 gui=NONE
hi Search  guifg=NONE guibg=#656657 gui=NONE
hi Directory  guifg=#7ab8d7 guibg=NONE gui=NONE
hi Folded  guifg=#747676 guibg=#242322 gui=NONE

hi Normal  guifg=#e5e1dc guibg=#242322 gui=NONE
hi Boolean  guifg=#6e9cbe guibg=NONE gui=NONE
hi Character  guifg=#7ab8d7 guibg=NONE gui=NONE
hi Comment  guifg=#747676 guibg=NONE gui=italic
hi Conditional  guifg=#e9eec2 guibg=NONE gui=NONE
hi Constant  guifg=#7ab8d7 guibg=NONE gui=NONE
hi Define  guifg=#e9eec2 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=#990000 gui=NONE
hi WarningMsg  guifg=#ffffff guibg=#990000 gui=NONE
hi Float  guifg=#fda35e guibg=NONE gui=NONE
hi Function  guifg=#d5584b guibg=NONE gui=NONE
hi Identifier  guifg=#e9eec2 guibg=NONE gui=NONE
hi Keyword  guifg=#e9eec2 guibg=NONE gui=NONE
hi Label  guifg=#7ab8d7 guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#333435 gui=NONE
hi Number  guifg=#fda35e guibg=NONE gui=NONE
hi Operator  guifg=#e9eec2 guibg=NONE gui=NONE
hi PreProc  guifg=#e9eec2 guibg=NONE gui=NONE
hi Special  guifg=#e5e1dc guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#333435 gui=NONE
hi Statement  guifg=#e9eec2 guibg=NONE gui=NONE
hi StorageClass  guifg=#e9eec2 guibg=NONE gui=NONE
hi String  guifg=#7ab8d7 guibg=NONE gui=NONE
hi Tag  guifg=#e87658 guibg=NONE gui=NONE
hi Title  guifg=#e5e1dc guibg=NONE gui=bold
hi Todo  guifg=#747676 guibg=NONE gui=inverse,bold,italic
hi Type  guifg=#ffffff guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#e9eec2 guibg=NONE gui=NONE
hi rubyFunction  guifg=#d5584b guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#7ab8d7 guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#7ab8d7 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#7ab8d7 guibg=NONE gui=NONE
hi rubyInclude  guifg=#e9eec2 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#7ab8d7 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#7ab8d7 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#7ab8d7 guibg=NONE gui=NONE
hi rubyEscape  guifg=#fda35e guibg=NONE gui=NONE
hi rubyControl  guifg=#e9eec2 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#e9eec2 guibg=NONE gui=NONE
hi rubyException  guifg=#e9eec2 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#7ab8d7 guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#d4584b guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#d4584b guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#d4584b guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#d4584b guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#747676 guibg=NONE gui=italic
hi erubyRailsMethod  guifg=#d4584b guibg=NONE gui=NONE
hi htmlTag  guifg=#e87658 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#e87658 guibg=NONE gui=NONE
hi htmlTagName  guifg=#e87658 guibg=NONE gui=NONE
hi htmlArg  guifg=#e87658 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#7ab8d7 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#e9eec2 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#d4584b guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#e87658 guibg=NONE gui=NONE
hi yamlAnchor  guifg=#7ab8d7 guibg=NONE gui=NONE
hi yamlAlias  guifg=#7ab8d7 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#7ab8d7 guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=#d4584b guibg=NONE gui=NONE
hi cssColor  guifg=#7ab8d7 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#e87658 guibg=NONE gui=NONE
hi cssClassName  guifg=#e87658 guibg=NONE gui=NONE
hi cssValueLength  guifg=#fda35e guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#fda35e guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
