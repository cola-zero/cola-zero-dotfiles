(setq auto-mode-alist (cons '("\\.po\\'\\|\\.po\\." . po-mode)
                            auto-mode-alist))
(autoload 'po-mode "po-mode"
  "Major mode for translators to edit PO files" t)
;; (autoload 'po-find-file-coding-system "po-compat")
;; (modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
;;                             'po-find-file-coding-system)

(provide 'config-po-mode)
