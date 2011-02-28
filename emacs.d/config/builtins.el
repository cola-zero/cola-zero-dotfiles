;; TRAMP
(require 'tramp nil t)
;; http://www.trashpot.org/scratch/2008/05/tramp_zsh.html
(setq tramp-default-method "scpx")
;; https://www.asp-edita.jp/doda/one/doda7807_155.html
(defadvice tramp-handle-vc-registered (around tramp-handle-vc-registered-around activate)
  (let ((vc-handled-backends '(SVN Git))) ad-do-it))


;; gdb
(setq gdb-many-windows t)
;;; 変数の上にマウスカーソルを置くと値を表示
(add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t)))
;;; I/O バッファを表示
(setq gdb-use-separate-io-buffer t)
;;; t にすると mini buffer に値が表示される
(setq gud-tooltip-echo-area nil)
