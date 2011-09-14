(setq rsense-home (expand-file-name "~/.emacs.d/vendor/rsense"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)