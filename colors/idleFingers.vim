" Vim color file
" Converted from Textmate theme idleFingers using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "idleFingers"

hi Cursor  guifg=NONE guibg=#91ff00 gui=NONE
hi Visual  guifg=NONE guibg=#555e74 gui=NONE
hi CursorLine  guifg=NONE guibg=#353637 gui=NONE
hi CursorColumn  guifg=NONE guibg=#353637 gui=NONE
hi LineNr  guifg=#999999 guibg=#323232 gui=NONE
hi VertSplit  guifg=#595959 guibg=#595959 gui=NONE
hi MatchParen  guifg=#cc7833 guibg=NONE gui=NONE
hi StatusLine  guifg=#ffffff guibg=#595959 gui=bold
hi StatusLineNC  guifg=#ffffff guibg=#595959 gui=NONE
hi Pmenu  guifg=#ffc66d guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#555e74 gui=NONE
hi IncSearch  guifg=NONE guibg=#654932 gui=NONE
hi Search  guifg=NONE guibg=#654932 gui=NONE
hi Directory  guifg=#6c99bb guibg=NONE gui=NONE
hi Folded  guifg=#bc9458 guibg=#323232 gui=NONE

hi Normal  guifg=#ffffff guibg=#323232 gui=NONE
hi Boolean  guifg=#6c99bb guibg=NONE gui=NONE
hi Character  guifg=#6c99bb guibg=NONE gui=NONE
hi Comment  guifg=#bc9458 guibg=NONE gui=italic
hi Conditional  guifg=#cc7833 guibg=NONE gui=NONE
hi Constant  guifg=#6c99bb guibg=NONE gui=NONE
hi Define  guifg=#cc7833 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=#ff0000 gui=NONE
hi WarningMsg  guifg=#ffffff guibg=#ff0000 gui=NONE
hi Float  guifg=#6c99bb guibg=NONE gui=NONE
hi Function  guifg=#ffc66d guibg=NONE gui=NONE
hi Identifier  guifg=NONE guibg=NONE gui=NONE
hi Keyword  guifg=#cc7833 guibg=NONE gui=NONE
hi Label  guifg=#a5c261 guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#353637 gui=NONE
hi Number  guifg=#6c99bb guibg=NONE gui=NONE
hi Operator  guifg=#cc7833 guibg=NONE gui=NONE
hi PreProc  guifg=#cc7833 guibg=NONE gui=NONE
hi Special  guifg=#ffffff guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#353637 gui=NONE
hi Statement  guifg=#cc7833 guibg=NONE gui=NONE
hi StorageClass  guifg=NONE guibg=NONE gui=NONE
hi String  guifg=#a5c261 guibg=NONE gui=NONE
hi Tag  guifg=#ffc66d guibg=NONE gui=NONE
hi Title  guifg=#ffffff guibg=NONE gui=bold
hi Todo  guifg=#bc9458 guibg=NONE gui=inverse,bold,italic
hi Type  guifg=#ffc66d guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#cc7833 guibg=NONE gui=NONE
hi rubyFunction  guifg=#ffc66d guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#6c99bb guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#a5c261 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#cc7833 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#b7dff8 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#cccc33 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#cccc33 guibg=NONE gui=NONE
hi rubyEscape  guifg=#6c99bb guibg=NONE gui=NONE
hi rubyControl  guifg=#cc7833 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#cc7833 guibg=NONE gui=NONE
hi rubyException  guifg=#cc7833 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#cccc33 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#b83426 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#b83426 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#b83426 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#b83426 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#bc9458 guibg=NONE gui=italic
hi erubyRailsMethod  guifg=#b83426 guibg=NONE gui=NONE
hi htmlTag  guifg=#ffe5bb guibg=NONE gui=NONE
hi htmlEndTag  guifg=#ffe5bb guibg=NONE gui=NONE
hi htmlTagName  guifg=#ffe5bb guibg=NONE gui=NONE
hi htmlArg  guifg=#ffe5bb guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#6c99bb guibg=NONE gui=NONE
hi javaScriptFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#b83426 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#ffc66d guibg=NONE gui=NONE
hi yamlAnchor  guifg=#b7dff8 guibg=NONE gui=NONE
hi yamlAlias  guifg=#b7dff8 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#a5c261 guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=#b83426 guibg=NONE gui=NONE
hi cssColor  guifg=#6c99bb guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=NONE guibg=NONE gui=NONE
hi cssClassName  guifg=NONE guibg=NONE gui=NONE
hi cssValueLength  guifg=#6c99bb guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#6c99bb guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
