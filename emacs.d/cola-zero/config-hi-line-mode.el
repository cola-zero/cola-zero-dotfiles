(global-hl-line-mode t)
(defface my-hl-line-face
  '((((class color) (background dark))  ; カラーかつ, 背景が dark ならば,
     (:background "gray13" t))   ; 背景を黒に.
    (((class color) (background light)) ; カラーかつ, 背景が light ならば,
     (:background "white" t))     ; 背景を ForestGreen に.
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)

(provide 'config-hi-line-mode)
