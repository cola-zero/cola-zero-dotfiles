;(require 'ruby-electric)
(eval-after-load "ruby-electric"
  '(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t))))

(provide 'config-ruby-electric)
