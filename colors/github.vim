" Vim color file
" Converted from Textmate theme GitHub using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "GitHub"

hi Cursor  guifg=NONE guibg=#000000 gui=NONE
hi Visual  guifg=NONE guibg=#bcd5fa gui=NONE
hi CursorLine  guifg=NONE guibg=#e7e7ed gui=NONE
hi CursorColumn  guifg=NONE guibg=#e7e7ed gui=NONE
hi LineNr  guifg=#7c7c80 guibg=#f8f8ff gui=NONE
hi VertSplit  guifg=#c9c9cf guibg=#c9c9cf gui=NONE
hi MatchParen  guifg=#000000 guibg=NONE gui=bold
hi StatusLine  guifg=#000000 guibg=#c9c9cf gui=bold
hi StatusLineNC  guifg=#000000 guibg=#c9c9cf gui=NONE
hi Pmenu  guifg=#445588 guibg=NONE gui=bold
hi PmenuSel  guifg=NONE guibg=#bcd5fa gui=NONE
hi IncSearch  guifg=NONE guibg=#a6a6ab gui=NONE
hi Search  guifg=NONE guibg=#a6a6ab gui=NONE
hi Directory  guifg=#aa2c8c guibg=NONE gui=NONE
hi Folded  guifg=#999988 guibg=#f8f8ff gui=NONE

hi Normal  guifg=#000000 guibg=#f8f8ff gui=NONE
hi Boolean  guifg=#000000 guibg=NONE gui=bold
hi Character  guifg=NONE guibg=NONE gui=NONE
hi Comment  guifg=#999988 guibg=NONE gui=italic
hi Conditional  guifg=#000000 guibg=NONE gui=bold
hi Constant  guifg=NONE guibg=NONE gui=NONE
hi Define  guifg=#000000 guibg=NONE gui=bold
hi ErrorMsg  guifg=NONE guibg=NONE gui=NONE
hi WarningMsg  guifg=NONE guibg=NONE gui=NONE
hi Float  guifg=#009999 guibg=NONE gui=NONE
hi Function  guifg=#990000 guibg=NONE gui=bold
hi Identifier  guifg=#000000 guibg=NONE gui=bold
hi Keyword  guifg=#000000 guibg=NONE gui=bold
hi Label  guifg=#dd1144 guibg=NONE gui=NONE
hi NonText  guifg=#bfbfbf guibg=#e7e7ed gui=NONE
hi Number  guifg=#009999 guibg=NONE gui=NONE
hi Operator  guifg=#000000 guibg=NONE gui=bold
hi PreProc  guifg=#000000 guibg=NONE gui=bold
hi Special  guifg=#000000 guibg=NONE gui=NONE
hi SpecialKey  guifg=#bfbfbf guibg=#e7e7ed gui=NONE
hi Statement  guifg=#000000 guibg=NONE gui=bold
hi StorageClass  guifg=#000000 guibg=NONE gui=bold
hi String  guifg=#dd1144 guibg=NONE gui=NONE
hi Tag  guifg=#121289 guibg=NONE gui=NONE
hi Title  guifg=#000000 guibg=NONE gui=bold
hi Todo  guifg=#999988 guibg=NONE gui=inverse,bold,italic
hi Type  guifg=#445588 guibg=NONE gui=bold
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#000000 guibg=NONE gui=bold
hi rubyFunction  guifg=#990000 guibg=NONE gui=bold
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#aa2c8c guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#dd1144 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#108888 guibg=NONE gui=NONE
hi rubyInclude  guifg=#000000 guibg=NONE gui=bold
hi rubyGlobalVariable  guifg=#108888 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#009926 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#009926 guibg=NONE gui=NONE
hi rubyEscape  guifg=NONE guibg=NONE gui=NONE
hi rubyControl  guifg=#000000 guibg=NONE gui=bold
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#000000 guibg=NONE gui=bold
hi rubyException  guifg=#000000 guibg=NONE gui=bold
hi rubyPseudoVariable  guifg=#108888 guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#008080 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi erubyDelimiter  guifg=#999999 guibg=NONE gui=bold
hi erubyComment  guifg=#999988 guibg=NONE gui=italic
hi erubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi htmlTag  guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag  guifg=NONE guibg=NONE gui=NONE
hi htmlTagName  guifg=NONE guibg=NONE gui=NONE
hi htmlArg  guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=NONE guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#000000 guibg=NONE gui=bold
hi javaScriptRailsFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#121289 guibg=NONE gui=NONE
hi yamlAnchor  guifg=#108888 guibg=NONE gui=NONE
hi yamlAlias  guifg=#108888 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#dd1144 guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=NONE guibg=NONE gui=NONE
hi cssColor  guifg=#009999 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#000000 guibg=NONE gui=NONE
hi cssClassName  guifg=#445588 guibg=NONE gui=bold
hi cssValueLength  guifg=#009999 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#000000 guibg=NONE gui=bold
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
