(setq user-mail-address "colazero@mail.mkoga.net"
      user-full-name "Masahiro Koga")

(setq gnus-ignored-from-addresses "masahirokoga")

(setq gnus-select-method
      '(nnimap "Mail"
               (nnimap-address "localhost")
               (nnimap-stream network)
               (nnir-search-engine imap)
               ))
(add-to-list 'gnus-secondary-select-methods
             '(nntp "news.gnus.org"))

(add-to-list 'gnus-secondary-select-methods
                   '(nnimap "gmail"
               (nnimap-address "imap.gmail.com")
               (nnimap-server-port 993)
               (nnimap-authinfo-file "~/.emacs.d/.authinfo")
               (nnimap-stream ssl)
               (nnir-search-engine imap)
               ))

(setq gnus-posting-styles
      '((".*"
         (name "Masahiro Koga")
         (address "colazero@mail.mkoga.net"))
        ("colazero0"
         (address "colazero0@gmail.com"))
        ("org-ja"
         (address "colazero0@gmail.com")
         (to-address "Org2ja-devel@lists.sourceforge.net"))
        ("kumamoto-u"
         (address "koga@arch.cs.kumamoto-u.ac.jp"))
        ("masahirokoga@gmail.com"
         (address "masahirokoga@gmail.com"))
        ))

(setq message-send-mail-function 'smtpmail-send-it
      send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587
				   "colazero@mail.mkoga.net" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      ;; Cc: and Bcc: to header of message-mode.
      message-default-mail-headers "Cc: \nBcc: \n")


;; use w3m for render html
;; (setq mm-text-html-renderer 'w3m)
;; (setq mm-inline-text-html-with-images t)
