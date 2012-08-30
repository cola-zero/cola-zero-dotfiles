;; config-znc.el
;; (setq erc-current-nick-highlight-type 'nick-or-keyword)
;; (setq erc-keywords'("\\bswing\\b" "\\b[rR]uby\\b"
;;                     "\\bemacs\\b"))
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))
;; (setq erc-trck-use-faces t)
;; (setq erc-track-faces-priority-list
;;       '(erc-current-nick-face erc-keyword-face))
;; (setq erc-track-priority-faces-only 'all)

(provide 'config-znc)
