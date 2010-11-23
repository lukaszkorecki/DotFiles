" Vim color file
" Converted from Textmate theme Birds of Paradise using Coloration v0.2.5 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Birds of Paradise"

hi Cursor  guifg=NONE guibg=#e6e1c4 gui=NONE
hi Visual  guifg=NONE guibg=#16120e gui=NONE
hi CursorLine  guifg=NONE guibg=#1f1611 gui=NONE
hi CursorColumn  guifg=NONE guibg=#1f1611 gui=NONE
hi LineNr  guifg=#8f8475 guibg=#372725 gui=NONE
hi VertSplit  guifg=#584a43 guibg=#584a43 gui=NONE
hi MatchParen  guifg=#ef5d32 guibg=NONE gui=NONE
hi StatusLine  guifg=#e6e1c4 guibg=#584a43 gui=bold
hi StatusLineNC  guifg=#e6e1c4 guibg=#584a43 gui=NONE
hi Pmenu  guifg=#efac32 guibg=NONE gui=bold
hi PmenuSel  guifg=NONE guibg=#16120e gui=NONE
hi IncSearch  guifg=NONE guibg=#743929 gui=NONE
hi Search  guifg=NONE guibg=#743929 gui=NONE
hi Directory  guifg=#6c99bb guibg=NONE gui=NONE
hi Folded  guifg=#6b4e32 guibg=#372725 gui=NONE

hi Normal  guifg=#e6e1c4 guibg=#372725 gui=NONE
hi Boolean  guifg=#6c99bb guibg=NONE gui=NONE
hi Character  guifg=#6c99bb guibg=NONE gui=NONE
hi Comment  guifg=#6b4e32 guibg=NONE gui=italic
hi Conditional  guifg=#ef5d32 guibg=NONE gui=NONE
hi Constant  guifg=#6c99bb guibg=NONE gui=NONE
hi Define  guifg=#ef5d32 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=#990000 gui=NONE
hi WarningMsg  guifg=#ffffff guibg=#990000 gui=NONE
hi Float  guifg=#6c99bb guibg=NONE gui=NONE
hi Function  guifg=#efac32 guibg=NONE gui=NONE
hi Identifier  guifg=#ef5d32 guibg=NONE gui=NONE
hi Keyword  guifg=#ef5d32 guibg=NONE gui=NONE
hi Label  guifg=#d9d762 guibg=NONE gui=NONE
hi NonText  guifg=#42302d guibg=#1f1611 gui=NONE
hi Number  guifg=#6c99bb guibg=NONE gui=NONE
hi Operator  guifg=#ef5d32 guibg=NONE gui=NONE
hi PreProc  guifg=#ef5d32 guibg=NONE gui=NONE
hi Special  guifg=#e6e1c4 guibg=NONE gui=NONE
hi SpecialKey  guifg=#42302d guibg=#1f1611 gui=NONE
hi Statement  guifg=#ef5d32 guibg=NONE gui=NONE
hi StorageClass  guifg=#ef5d32 guibg=NONE gui=NONE
hi String  guifg=#d9d762 guibg=NONE gui=NONE
hi Tag  guifg=#efcb43 guibg=NONE gui=NONE
hi Title  guifg=#e6e1c4 guibg=NONE gui=bold
hi Todo  guifg=#6b4e32 guibg=NONE gui=inverse,bold,italic
hi Type  guifg=#efac32 guibg=NONE gui=bold
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyFunction  guifg=#efac32 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#6c99bb guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#d9d762 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#7daf9c guibg=NONE gui=NONE
hi rubyInclude  guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#7daf9c guibg=NONE gui=NONE
hi rubyRegexp  guifg=#d9d762 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#d9d762 guibg=NONE gui=NONE
hi rubyEscape  guifg=#7daf9c guibg=NONE gui=NONE
hi rubyControl  guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyException  guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#7daf9c guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#efac32 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#efac32 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#efac32 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#efac32 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#6b4e32 guibg=NONE gui=italic
hi erubyRailsMethod  guifg=#efac32 guibg=NONE gui=NONE
hi htmlTag  guifg=#efcb43 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#efcb43 guibg=NONE gui=NONE
hi htmlTagName  guifg=#efcb43 guibg=NONE gui=NONE
hi htmlArg  guifg=#efcb43 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#6c99bb guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#ef5d32 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#efac32 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#efcb43 guibg=NONE gui=NONE
hi yamlAnchor  guifg=#7daf9c guibg=NONE gui=NONE
hi yamlAlias  guifg=#7daf9c guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#d9d762 guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=#efac32 guibg=NONE gui=NONE
hi cssColor  guifg=#6c99bb guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#efcb43 guibg=NONE gui=NONE
hi cssClassName  guifg=#efcb43 guibg=NONE gui=NONE
hi cssValueLength  guifg=#6c99bb guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#6c99bb guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE