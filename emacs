;;;
;;; .emacs
;;; 


;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 85))

;; カレントウィンドウの透明度を変更する (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 85)

(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-arjen))

