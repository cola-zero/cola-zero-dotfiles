(require 'nrepl)

(add-hook 'clojure-mode-hook
          'nrepl-interaction-mode)

(add-hook 'nrepl-interaction-mode-hook
          'nrepl-turn-on-eldoc-mode)

(setq nrepl-popup-stacktraces t)

(add-to-list 'same-window-buffer-names "*nrepl*")

(provide 'config-nrepl)
