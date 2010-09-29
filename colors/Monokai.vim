" Vim color file
" Converted from Textmate theme Monokai using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Monokai"

hi Cursor  guifg=NONE guibg=#f8f8f0 gui=NONE
hi Visual  guifg=NONE guibg=#49483e gui=NONE
hi CursorLine  guifg=NONE guibg=#3e3d32 gui=NONE
hi CursorColumn  guifg=NONE guibg=#3e3d32 gui=NONE
hi LineNr  guifg=#90908a guibg=#272822 gui=NONE
hi VertSplit  guifg=#4f504a guibg=#4f504a gui=NONE
hi MatchParen  guifg=#f92672 guibg=NONE gui=NONE
hi StatusLine  guifg=#f8f8f2 guibg=#4f504a gui=bold
hi StatusLineNC  guifg=#f8f8f2 guibg=#4f504a gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#49483e gui=NONE
hi IncSearch  guifg=NONE guibg=#6c273c gui=NONE
hi Search  guifg=NONE guibg=#6c273c gui=NONE
hi Directory  guifg=#ae81ff guibg=NONE gui=NONE
hi Folded  guifg=#75715e guibg=#272822 gui=NONE

hi Normal  guifg=#f8f8f2 guibg=#272822 gui=NONE
hi Boolean  guifg=#ae81ff guibg=NONE gui=NONE
hi Character  guifg=#ae81ff guibg=NONE gui=NONE
hi Comment  guifg=#75715e guibg=NONE gui=NONE
hi Conditional  guifg=#f92672 guibg=NONE gui=NONE
hi Constant  guifg=NONE guibg=NONE gui=NONE
hi Define  guifg=#f92672 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi WarningMsg  guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi Float  guifg=#ae81ff guibg=NONE gui=NONE
hi Function  guifg=#a6e22e guibg=NONE gui=NONE
hi Identifier  guifg=#66d9ef guibg=NONE gui=italic
hi Keyword  guifg=#f92672 guibg=NONE gui=NONE
hi Label  guifg=#e6db74 guibg=NONE gui=NONE
hi NonText  guifg=#3b3a32 guibg=#3e3d32 gui=NONE
hi Number  guifg=#ae81ff guibg=NONE gui=NONE
hi Operator  guifg=#f92672 guibg=NONE gui=NONE
hi PreProc  guifg=#f92672 guibg=NONE gui=NONE
hi Special  guifg=#f8f8f2 guibg=NONE gui=NONE
hi SpecialKey  guifg=#3b3a32 guibg=#3e3d32 gui=NONE
hi Statement  guifg=#f92672 guibg=NONE gui=NONE
hi StorageClass  guifg=#66d9ef guibg=NONE gui=italic
hi String  guifg=#e6db74 guibg=NONE gui=NONE
hi Tag  guifg=#f92672 guibg=NONE gui=NONE
hi Title  guifg=#f8f8f2 guibg=NONE gui=bold
hi Todo  guifg=#75715e guibg=NONE gui=inverse,bold
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#f92672 guibg=NONE gui=NONE
hi rubyFunction  guifg=#a6e22e guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#ae81ff guibg=NONE gui=NONE
hi rubyConstant  guifg=#66d9ef guibg=NONE gui=italic
hi rubyStringDelimiter  guifg=#e6db74 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=#fd971f guibg=NONE gui=italic
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#f92672 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp  guifg=#e6db74 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#e6db74 guibg=NONE gui=NONE
hi rubyEscape  guifg=#ae81ff guibg=NONE gui=NONE
hi rubyControl  guifg=#f92672 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#f92672 guibg=NONE gui=NONE
hi rubyException  guifg=#f92672 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#66d9ef guibg=NONE gui=italic
hi rubyRailsARAssociationMethod  guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#66d9ef guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#75715e guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=#66d9ef guibg=NONE gui=NONE
hi htmlTag  guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag  guifg=NONE guibg=NONE gui=NONE
hi htmlTagName  guifg=NONE guibg=NONE gui=NONE
hi htmlArg  guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#ae81ff guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#66d9ef guibg=NONE gui=italic
hi javaScriptRailsFunction  guifg=#66d9ef guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#f92672 guibg=NONE gui=NONE
hi yamlAnchor  guifg=NONE guibg=NONE gui=NONE
hi yamlAlias  guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#e6db74 guibg=NONE gui=NONE
hi cssURL  guifg=#fd971f guibg=NONE gui=italic
hi cssFunctionName  guifg=#66d9ef guibg=NONE gui=NONE
hi cssColor  guifg=#ae81ff guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#a6e22e guibg=NONE gui=NONE
hi cssClassName  guifg=#a6e22e guibg=NONE gui=NONE
hi cssValueLength  guifg=#ae81ff guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#66d9ef guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
