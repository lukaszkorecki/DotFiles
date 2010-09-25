" Vim color file
" Converted from Textmate theme Merbivore Soft using Coloration v0.2.3 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Merbivore Soft"

hi Cursor  guifg=NONE guibg=#ffffff gui=NONE
hi Visual  guifg=NONE guibg=#35213e gui=NONE
hi CursorLine  guifg=NONE guibg=#333435 gui=NONE
hi CursorColumn  guifg=NONE guibg=#333435 gui=NONE
hi LineNr  guifg=#817f7c guibg=#1c1c1c gui=NONE
hi VertSplit  guifg=#424140 guibg=#424140 gui=NONE
hi MatchParen  guifg=#fc803a guibg=NONE gui=NONE
hi StatusLine  guifg=#e6e1dc guibg=#424140 gui=bold
hi StatusLineNC  guifg=#e6e1dc guibg=#424140 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#35213e gui=NONE
hi IncSearch  guifg=NONE guibg=#663d26 gui=NONE
hi Search  guifg=NONE guibg=#663d26 gui=NONE
hi Directory  guifg=#68c1d8 guibg=NONE gui=NONE
hi Folded  guifg=#ac4bb8 guibg=#1c1c1c gui=NONE

hi Normal  guifg=#e6e1dc guibg=#1c1c1c gui=NONE
hi Boolean  guifg=#e1c582 guibg=NONE gui=NONE
hi Character  guifg=#68c1d8 guibg=NONE gui=NONE
hi Comment  guifg=#ac4bb8 guibg=NONE gui=italic
hi Conditional  guifg=#fc803a guibg=NONE gui=NONE
hi Constant  guifg=#68c1d8 guibg=NONE gui=NONE
hi Define  guifg=#fc803a guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=#fe3838 gui=NONE
hi WarningMsg  guifg=#ffffff guibg=#fe3838 gui=NONE
hi Float  guifg=#7fc578 guibg=NONE gui=NONE
hi Function  guifg=NONE guibg=NONE gui=NONE
hi Identifier  guifg=#fc803a guibg=NONE gui=NONE
hi Keyword  guifg=#fc803a guibg=NONE gui=NONE
hi Label  guifg=#8ec65f guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#333435 gui=NONE
hi Number  guifg=#7fc578 guibg=NONE gui=NONE
hi Operator  guifg=#fc803a guibg=NONE gui=NONE
hi PreProc  guifg=#fc803a guibg=NONE gui=NONE
hi Special  guifg=#e6e1dc guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#333435 gui=NONE
hi Statement  guifg=#fc803a guibg=NONE gui=NONE
hi StorageClass  guifg=#fc803a guibg=NONE gui=NONE
hi String  guifg=#8ec65f guibg=NONE gui=NONE
hi Tag  guifg=#fc803a guibg=NONE gui=NONE
hi Title  guifg=#e6e1dc guibg=NONE gui=bold
hi Todo  guifg=#ac4bb8 guibg=NONE gui=inverse,bold,italic
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#fc803a guibg=NONE gui=NONE
hi rubyFunction  guifg=NONE guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#68c1d8 guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#8ec65f guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#fc803a guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp  guifg=#8ec65f guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#8ec65f guibg=NONE gui=NONE
hi rubyEscape  guifg=#b3e5b4 guibg=NONE gui=NONE
hi rubyControl  guifg=#fc803a guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#fc803a guibg=NONE gui=NONE
hi rubyException  guifg=#fc803a guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#ac4bb8 guibg=NONE gui=italic
hi erubyRailsMethod  guifg=NONE guibg=NONE gui=NONE
hi htmlTag  guifg=#fc803a guibg=NONE gui=NONE
hi htmlEndTag  guifg=#fc803a guibg=NONE gui=NONE
hi htmlTagName  guifg=#fc803a guibg=NONE gui=NONE
hi htmlArg  guifg=#fc803a guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#68c1d8 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#fc803a guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#fc803a guibg=NONE gui=NONE
hi yamlAnchor  guifg=NONE guibg=NONE gui=NONE
hi yamlAlias  guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#8ec65f guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=NONE guibg=NONE gui=NONE
hi cssColor  guifg=#68c1d8 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#eaf1a3 guibg=NONE gui=NONE
hi cssClassName  guifg=#eaf1a3 guibg=NONE gui=NONE
hi cssValueLength  guifg=#7fc578 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#8ec65f guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
