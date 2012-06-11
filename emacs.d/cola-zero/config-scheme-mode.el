(add-to-list 'exec-path (expand-file-name "~/opt/gauche/bin"))
(add-to-list 'process-coding-system-alist '("gosh" utf-8 . utf-8))

(setq scheme-program-name "gosh -i")
