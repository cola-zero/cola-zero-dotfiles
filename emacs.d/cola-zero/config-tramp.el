;; TRAMP
;; http://www.trashpot.org/scratch/2008/05/tramp_zsh.html
(setq tramp-default-method "scpx")
;; https://www.asp-edita.jp/doda/one/doda7807_155.html
(defadvice tramp-handle-vc-registered (around tramp-handle-vc-registered-around activate)
  (let ((vc-handled-backends '(SVN Git))) ad-do-it))

(provide 'config-tramp)
