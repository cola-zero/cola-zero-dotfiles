(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(if (eq system-type 'darwin)
    (progn
      (setq migemo-coding-system 'utf-8-unix)
      (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict"))
  (progn
    (setq migemo-coding-system 'euc-jp-unix)
    (setq migemo-dictionary "/usr/share/migemo/euc-jp/migemo-dict"))
  )
(load-library "migemo")
(migemo-init)

(provide 'config-migemo)
