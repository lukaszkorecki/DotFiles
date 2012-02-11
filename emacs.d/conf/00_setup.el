; Set a list of repos
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("Tromey" . "http://tromey.com/elpa/")))

(package-initialize)

(defun provide-package (name)
  (when (not (package-installed-p name))
    (package-refresh-contents)
    (package-install pkg)))
