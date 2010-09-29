" Vim color file
" Converted from Textmate theme Merbivore using Coloration v0.2.3 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Merbivore"

hi Cursor  guifg=NONE guibg=#ffffff gui=NONE
hi Visual  guifg=NONE guibg=#515a70 gui=NONE
hi CursorLine  guifg=NONE guibg=#333435 gui=NONE
hi CursorColumn  guifg=NONE guibg=#333435 gui=NONE
hi LineNr  guifg=#7e7c79 guibg=#161616 gui=NONE
hi VertSplit  guifg=#3e3d3c guibg=#3e3d3c gui=NONE
hi MatchParen  guifg=#fc6f09 guibg=NONE gui=NONE
hi StatusLine  guifg=#e6e1dc guibg=#3e3d3c gui=bold
hi StatusLineNC  guifg=#e6e1dc guibg=#3e3d3c gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#515a70 gui=NONE
hi IncSearch  guifg=NONE guibg=#623312 gui=NONE
hi Search  guifg=NONE guibg=#623312 gui=NONE
hi Directory  guifg=#1edafb guibg=NONE gui=NONE
hi Folded  guifg=#ad2ea4 guibg=#161616 gui=NONE

hi Normal  guifg=#e6e1dc guibg=#161616 gui=NONE
hi Boolean  guifg=#fdc251 guibg=NONE gui=NONE
hi Character  guifg=#1edafb guibg=NONE gui=NONE
hi Comment  guifg=#ad2ea4 guibg=NONE gui=italic
hi Conditional  guifg=#fc6f09 guibg=NONE gui=NONE
hi Constant  guifg=#1edafb guibg=NONE gui=NONE
hi Define  guifg=#fc6f09 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=#990000 gui=NONE
hi WarningMsg  guifg=#ffffff guibg=#990000 gui=NONE
hi Float  guifg=#58c554 guibg=NONE gui=NONE
hi Function  guifg=NONE guibg=NONE gui=NONE
hi Identifier  guifg=#fc6f09 guibg=NONE gui=NONE
hi Keyword  guifg=#fc6f09 guibg=NONE gui=NONE
hi Label  guifg=#8dff0a guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#333435 gui=NONE
hi Number  guifg=#58c554 guibg=NONE gui=NONE
hi Operator  guifg=#fc6f09 guibg=NONE gui=NONE
hi PreProc  guifg=#fc6f09 guibg=NONE gui=NONE
hi Special  guifg=#e6e1dc guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#333435 gui=NONE
hi Statement  guifg=#fc6f09 guibg=NONE gui=NONE
hi StorageClass  guifg=#fc6f09 guibg=NONE gui=NONE
hi String  guifg=#8dff0a guibg=NONE gui=NONE
hi Tag  guifg=#fc6f09 guibg=NONE gui=NONE
hi Title  guifg=#e6e1dc guibg=NONE gui=bold
hi Todo  guifg=#ad2ea4 guibg=NONE gui=inverse,bold,italic
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#fc6f09 guibg=NONE gui=NONE
hi rubyFunction  guifg=NONE guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#1edafb guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#8dff0a guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#fc6f09 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp  guifg=#8dff0a guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#8dff0a guibg=NONE gui=NONE
hi rubyEscape  guifg=#519f50 guibg=NONE gui=NONE
hi rubyControl  guifg=#fc6f09 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#fc6f09 guibg=NONE gui=NONE
hi rubyException  guifg=#fc6f09 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#ad2ea4 guibg=NONE gui=italic
hi erubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi htmlTag  guifg=#fc6f09 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#fc6f09 guibg=NONE gui=NONE
hi htmlTagName  guifg=#fc6f09 guibg=NONE gui=NONE
hi htmlArg  guifg=#fc6f09 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#1edafb guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#fc6f09 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#fc6f09 guibg=NONE gui=NONE
hi yamlAnchor  guifg=NONE guibg=NONE gui=NONE
hi yamlAlias  guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#8dff0a guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=NONE guibg=NONE gui=NONE
hi cssColor  guifg=#1edafb guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#ffff89 guibg=NONE gui=NONE
hi cssClassName  guifg=#ffff89 guibg=NONE gui=NONE
hi cssValueLength  guifg=#58c554 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#8dff0a guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
