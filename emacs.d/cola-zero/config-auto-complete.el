(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'ruby-mode)
(add-to-list 'ac-modes 'verilog-mode)
(add-to-list 'ac-sources 'ac-source-gtags)

(provide 'config-auto-complete)
