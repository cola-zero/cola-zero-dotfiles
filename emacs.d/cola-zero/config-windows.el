(setq win:switch-prefix "\C-z")
(define-key global-map win:switch-prefix nil)
;; ` は「直前の状態」
(setq win:base-key ?`)
;; ` 〜 z は27文字
(setq win:max-configs 27)
;; C-c英字 に割り当てない
(setq win:quick-selection nil)
(require 'windows)
(setq win:use-frame nil)
(win:startup-with-window)
;; C-xCでwindow状態を保存してemacsを終了する
(define-key ctl-x-map "C" 'see-you-again)
(define-key win:switch-map "\C-z" 'win-toggle-window)
(run-with-idle-timer 30 t 'win-save-all-configurations)

(provide 'config-windows)
