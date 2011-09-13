(vendor 'emacs-window-layout)
(vendor 'emacs-window-manager)
(require 'window-layout)
(require 'e2wm-config)
(require 'e2wm-vcs)
(global-set-key (kbd "M-+") 'e2wm:start-management)
(e2wm:add-keymap
 e2wm:pst-minor-mode-keymap
 '(("M-g" . e2wm:dp-magit))
 e2wm:prefix-key)
