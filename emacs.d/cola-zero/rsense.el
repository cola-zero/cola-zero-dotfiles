(setq rsense-home (expand-file-name "~/.emacs.d/vendor/rsense"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))
