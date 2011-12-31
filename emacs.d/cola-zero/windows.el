;; (setq win:switch-prefix "\C-z")
;; (define-key global-map win:switch-prefix nil)
;; (setq win:base-key ?`) ;; ` は「直前の状態」
;; (setq win:max-configs 27) ;; ` ～ z は 27 文字
;; (setq win:quick-selection nil) ;; C-c 英字 に割り当てない

;; (require 'windows)
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)
