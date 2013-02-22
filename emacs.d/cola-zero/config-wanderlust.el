;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/vendor/wanderlust/elmo"))
;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/vendor/wanderlust/utils"))
;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/vendor/wanderlust/wl"))
(require 'mime-w3m)
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
;; (setq wl-icon-directory
;;       (expand-file-name "~/.emacs.d/vendor/wanderlust/etc/icons"))
(setq wl-message-buffer-cache-size 20)
(setq wl-message-buffer-prefetch-depth 10)
(setq wl-message-buffer-prefetch-threshold nil)
(setq wl-auto-prefetch-first t)

(provide 'config-wanderlust)
