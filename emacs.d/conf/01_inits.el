; Packages  init and conf code

; Colors :-)
(provide-package 'color-theme)
(provide-package 'color-theme-molokai)


; Editing tools
(provide-package 'autopair)
(require 'autopair)
(autopair-global-mode)

(provide-package 'undo-tree)
(require 'undo-tree)

; Languages support

(provide-package 'ruby-mode)
(setq auto-mode-alist (cons '("\\Rakefile\\'" . ruby-mode) auto-mode-alist))

(provide-package 'markdown-mode )
(provide-package 'sass-mode )
(provide-package 'coffee-mode)
(provide-package 'css-mode )


;; Other tools and utils
(provide-package 'magit)
(require 'magit)


(provide-package 'jabber)
; TODO needs conf

; Speedbar-like-NERDtree
(provide-package 'speedbar)
(provide-package 'sr-speedbar)
(require 'speedbar)
(require 'sr-speedbar)


;;; Stuff not in elpa
;;;; EVIL
(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(require 'evil)  
(evil-mode 1)

;;;; Ack
(add-to-list 'load-path "~/.emacs.d/vendor/full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

