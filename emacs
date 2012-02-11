 ; Load stuff from diff files
(setq lk-conf-dir "~/.emacs.d/conf")
(if (file-exists-p lk-conf-dir)
       (dolist (file (directory-files lk-conf-dir t "\\.el$"))
	        (load file))) 
; Settings
; Line numbers
(global-linum-mode)

; Colors
(color-theme-molokai)

