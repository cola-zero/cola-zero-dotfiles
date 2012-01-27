;; ~/.emacs.d/cola-zero/keybind.el

;; C-F C-B C-P C-Nでウィンドウの移動
;; http://d.hatena.ne.jp/authorNari/20091225/1261667956
(setq windmove-wrap-around t)
(define-key global-map [(C shift n)] 'windmove-down)
(define-key global-map [(C shift p)] 'windmove-up)
(define-key global-map [(C shift b)] 'windmove-left)
(define-key global-map [(C shift f)] 'windmove-right)

;; マイ.emacs探訪 - I am Cruby!
;; http://d.hatena.ne.jp/authorNari/20091225/1261667956
(define-key global-map [(C S n)] 'windmove-down)
(define-key global-map [(C S p)] 'windmove-up)
(define-key global-map [(C S b)] 'windmove-left)
(define-key global-map [(C S f)] 'windmove-right)

(if (eq system-type 'darwin)
    (progn
      (define-key global-map [?¥] [?\\])
      (define-key global-map [?\C-¥] [?\C-\\])
      (define-key global-map [?\M-¥] [?\M-\\])
      (define-key global-map [?\C-\M-¥] [?\C-\M-\\])
      (global-set-key (kbd "M-<RET>") 'ns-toggle-fullscreen)
      ))

(provide 'config-keybind)
