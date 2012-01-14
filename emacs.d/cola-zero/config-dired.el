;; dired
(require 'dired-x)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
(setq insert-directory-program "/usr/local/bin/gls")
