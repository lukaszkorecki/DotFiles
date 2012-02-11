; Set a list of repos
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("Tromey" . "http://tromey.com/elpa/")))

(package-initialize)

; Packages which I need and use
(setq lk-required-packages
      (list 
       'sr-speedbar 
       'auto-indent-mode
       'autopair 
       'coffee-mode
       
       'color-theme-molokai 
       'css-mode 
       'diff-git 
       'jabber
       
       'magit 
       'markdown-mode 
       'rspec-mode 
       'mode-compile
       'ruby-end 
       'ruby-mode
       
       'sass-mode 
       'twitter
       'undo-tree))

; Install if not installed, otherwise - refresh
(dolist (pkg lk-required-packages)
  (when (not (package-installed-p pkg))
    (package-refresh-contents)
    (package-install pkg)))
