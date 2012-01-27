(require 'migemo)
(if (eq system-type 'darwin)
    (progn
      (setq migemo-command "cmigemo")
      (setq migemo-options '("-q" "--emacs"))
      (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
      (setq migemo-user-dictionary nil)
      (setq migemo-regex-dictionary nil)
      (setq migemo-coding-system 'utf-8-unix)
      (load-library "migemo"))
  (setq migemo-command "/usr/bin/ruby"))
(migemo-init)

(provide 'config-migemo)
