(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/rinari/util"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/rinari/util/jump"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/rinari/util/inf-ruby"))
(define-key rinari-minor-mode-map (kbd "C-c t") 'rinari-find-test)
(define-key rinari-minor-mode-map (kbd "C-c m") 'rinari-find-model)
(define-key rinari-minor-mode-map (kbd "C-c c") 'rinari-find-controller)
(define-key rinari-minor-mode-map (kbd "C-c v") 'rinari-find-view)