(tabbar-mode t)
(global-set-key (kbd "C-c C-<") 'tabbar-backward-group)
(global-set-key (kbd "C-c C->") 'tabbar-forward-group)
(global-set-key (kbd "C-<") 'tabbar-backward)
(global-set-key (kbd "C->") 'tabbar-forward)

(setq tabbar-cycle-scope (quote tabs))
(setq table-time-before-update 0.1)
(setq tabbar-use-images t)

(provide 'config-tabbar-mode)
