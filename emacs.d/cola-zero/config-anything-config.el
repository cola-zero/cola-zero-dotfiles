(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/anything-config/contrib"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/anything-config/extensions"))
(setq w3m-command "/usr/local/bin/w3m")
;; (require 'anything-config)
;; (require 'anything-migemo)
(require 'anything-startup)

(defvar anything-c-source-info-org-ja
  '((info-index . "org-ja")))

(defun anything-info-org-ja-at-point ()
  "'anything' for searching info of org-mode at point."
  (interactive)
  (anything '(anything-c-source-info-org-ja)
            (thing-at-point 'synbol) nil nil nil "*anything info"))
(global-set-key (kbd "<F1>o") 'anything-info-org-ja-at-point)
(global-set-key "\C-ho" 'anything-info-org-ja-at-point)
