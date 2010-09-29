" Vim color file
" Converted from Textmate theme Friendship Bracelet using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Friendship Bracelet"

hi Cursor  guifg=NONE guibg=#ffffff gui=NONE
hi Visual  guifg=NONE guibg=#685172 gui=NONE
hi CursorLine  guifg=NONE guibg=#404040 gui=NONE
hi CursorColumn  guifg=NONE guibg=#404040 gui=NONE
hi LineNr  guifg=#888888 guibg=#1f1f1f gui=NONE
hi VertSplit  guifg=#474747 guibg=#474747 gui=NONE
hi MatchParen  guifg=#ff8c56 guibg=NONE gui=NONE
hi StatusLine  guifg=#f1f1f1 guibg=#474747 gui=bold
hi StatusLineNC  guifg=#f1f1f1 guibg=#474747 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#685172 gui=NONE
hi IncSearch  guifg=NONE guibg=#694331 gui=NONE
hi Search  guifg=NONE guibg=#694331 gui=NONE
hi Directory  guifg=#389ad9 guibg=NONE gui=NONE
hi Folded  guifg=#8a8988 guibg=#1f1f1f gui=NONE

hi Normal  guifg=#f1f1f1 guibg=#1f1f1f gui=NONE
hi Boolean  guifg=#389ad9 guibg=NONE gui=NONE
hi Character  guifg=#389ad9 guibg=NONE gui=NONE
hi Comment  guifg=#8a8988 guibg=NONE gui=NONE
hi Conditional  guifg=#ff8c56 guibg=NONE gui=NONE
hi Constant  guifg=#389ad9 guibg=NONE gui=NONE
hi Define  guifg=#ff8c56 guibg=NONE gui=NONE
hi ErrorMsg  guifg=NONE guibg=NONE gui=NONE
hi WarningMsg  guifg=NONE guibg=NONE gui=NONE
hi Float  guifg=#389ad9 guibg=NONE gui=NONE
hi Function  guifg=#389ad9 guibg=NONE gui=NONE
hi Identifier  guifg=NONE guibg=NONE gui=NONE
hi Keyword  guifg=#ff8c56 guibg=NONE gui=NONE
hi Label  guifg=#f3f99a guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#404040 gui=NONE
hi Number  guifg=#389ad9 guibg=NONE gui=NONE
hi Operator  guifg=#ff8c56 guibg=NONE gui=NONE
hi PreProc  guifg=#ff8c56 guibg=NONE gui=NONE
hi Special  guifg=#f1f1f1 guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#404040 gui=NONE
hi Statement  guifg=#ff8c56 guibg=NONE gui=NONE
hi StorageClass  guifg=NONE guibg=NONE gui=NONE
hi String  guifg=#f3f99a guibg=NONE gui=NONE
hi Tag  guifg=#fc8c56 guibg=NONE gui=NONE
hi Title  guifg=#f1f1f1 guibg=NONE gui=bold
hi Todo  guifg=#8a8988 guibg=NONE gui=inverse,bold
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#ff8c56 guibg=NONE gui=NONE
hi rubyFunction  guifg=#389ad9 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#389ad9 guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#f3f99a guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#d4312c guibg=NONE gui=NONE
hi rubyInclude  guifg=#ff8c56 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#d4312c guibg=NONE gui=NONE
hi rubyRegexp  guifg=#ecf5a7 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#ecf5a7 guibg=NONE gui=NONE
hi rubyEscape  guifg=#389ad9 guibg=NONE gui=NONE
hi rubyControl  guifg=#ff8c56 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#ff8c56 guibg=NONE gui=NONE
hi rubyException  guifg=#ff8c56 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#d4312c guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#ff6666 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#ff6666 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#ff6666 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#ff6666 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#8a8988 guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=#ff6666 guibg=NONE gui=NONE
hi htmlTag  guifg=#389ad9 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#389ad9 guibg=NONE gui=NONE
hi htmlTagName  guifg=#389ad9 guibg=NONE gui=NONE
hi htmlArg  guifg=#389ad9 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#389ad9 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#ff6666 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#fc8c56 guibg=NONE gui=NONE
hi yamlAnchor  guifg=#d4312c guibg=NONE gui=NONE
hi yamlAlias  guifg=#d4312c guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#f3f99a guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=#ff6666 guibg=NONE gui=NONE
hi cssColor  guifg=#389ad9 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#389ad9 guibg=NONE gui=italic
hi cssClassName  guifg=#389ad9 guibg=NONE gui=italic
hi cssValueLength  guifg=#389ad9 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=NONE guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
