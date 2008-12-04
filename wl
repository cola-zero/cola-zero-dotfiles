;;; -*- mode: emacs-lisp; Coding: iso-2022-7bit -*-
;;; last updated : 2008/02/08 15:00:23 JST
;;;
;;;  Wanderlust $B@_$A6(%U%!%$%k(B

;;; $AR;0c5D$J%a$B!<$A%i$N2YWw$H(BGmail$A$G$N$B07$A$o$l7=$N$BBP1~$A1m(B
;;; https://mail.google.com/support/bin/answer.py?answer=77657

;; IMAP $A%5$B!<$A%P$N$B@_$A6((B
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "masahirokoga@gmail.com") ; $A%a$B!<$A%k%"%I%l%9(B
(setq elmo-imap4-default-authenticate-type 'clear)
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)
(setq elmo-imap4-use-modified-utf7 t) ; $AHU1>$B8l$A%U%)%k%@$BBP$A2_(B

;; SMTP $A%5$B!<$A%P$N$B@_$A6((B
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "masahirokoga@gmail.com") ; $BE,$ARKP^U}(B
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "gmail.com")

;; $AR;Rb$J(Bmessage-ID $BF0$A5D(BIP$A%"%I%l%9$N$B>l$A:O$K$B@_$A6(!#:N$+$BE,$A51$JNDWVAP$r!#@}$($P%a$B!<$A%k%"%I%l%9$H$+!#(B
(setq wl-from "Masahiro Koga <masahirokoga@gmail.com>")


;;;------------------------------------------
;;; $A$=$NK{$N$B@_$A6((B
;; $A%G%U%)%k%H$N%U%)%k%@(B
(setq wl-default-folder "%inbox")
;; $A%U%)%k%@C{$BJd$AMj$B;~$A$KJ9SC$9$k%G%U%)%k%H$N%9%Z%C%/(B
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP$A$NJK$BMM$A$K:O$o$;$F(B
(setq wl-trash-folder "%[Gmail]/Trash")
;; $AOB$B=q$A$-%G%#%l%/%H%j$r%m$B!<$A%+%k$K$B@_$A6($9$k(B.
(setq wl-draft-folder "+Drafts")
(setq wl-folder-check-async t) ; $A7GM,FZ$G%A%'%C%/$9$k$h$&$K(B
;; $A4s$-$J%a%C%;$B!<$A%8$r7V8n$7$FKMPE$7$J$$(B($A%G%U%)%k%H$O(Bt$A$G7V8n$9$k(B)
(setq mime-edit-split-message nil)
;; $AFp$BF0;~$A$+$i%*%U%i%$%s$K$9$k(B
;; (setq wl-plugged nil)
;; $A%5%^%j%b$B!<$A%I$GHU$B;~$A$rS"$B8l$A1mJ>(B
;; (setq wl-summary-weekday-name-lang 'en)
;; HTML$A%U%!%$%k$O1mJ>$7$J$$!#(B
(setq mime-setup-enable-inline-html nil)
;; $A%a$B!<$A%k$r$B=q$A$/$H$-$O$B8+$A3v$7;-Cf$r2P$7$F!"%U%k;-Cf$K$9$k(B
(setq wl-draft-reply-buffer-style 'keep)
;; $AKMPE$B:Q$A$_(BIMAP$A%U%)%k%@$OKMPE$HM,$B;~$A$K<H$BFI$A$K$9$k(B
(setq wl-fcc-force-as-read t)
;; $AWn3u$+$i%9%l%C%I$r$B3+$A$$$F$*$+$J$$(B
(setq wl-thread-insert-opened nil)
;; $A%9%l%C%I$r7V8n$9$k$7$-$$$BCM(B($A%G%U%)%k%H#:(B30)
(setq wl-summary-max-thread-depth 30)
;; $A>/8f$BL5$A$7$K$B3+$A$1$k%a$B!<$A%k%5%$%:$NWn4s$BCM(B($A%G%U%)%k%H#:(B30K)
(setq elmo-message-fetch-threshold 500000)
;; $A%W%j%U%'%C%A$B;~$A$K$B3NG'$A$rGs$a$k%a$B!<$A%k%5%$%:$NWn4s$BCM(B($A%G%U%)%k%H#:(B30K)
(setq wl-prefetch-threshold 500000)

;;;------------------------------------------
(setq wl-dispose-folder-alist
      (cons '("^%inbox" . remove) wl-dispose-folder-alist))


;;;------------------------------------------
;;; from,to $A$N%G%3$B!<$A%IV86(!#(B
(mime-set-field-decoder
 'From nil 'eword-decode-and-unfold-unstructured-field-body)
(mime-set-field-decoder
 'To nil 'eword-decode-and-unfold-unstructured-field-body)

;;;------------------------------------------
;; summary-mode $A$G$9$Y$F$N(B header $A$rR;5)3}H%(B
(setq mime-view-ignored-field-list '("^.*"))

;; $A1mJ>$9$k%X%C%@!#(B
(setq wl-message-visible-field-list
      (append mime-view-visible-field-list
        '("^Subject:" "^From:" "^To:" "^Cc:"
          "^X-Mailer:" "^X-Newsreader:" "^User-Agent:"
          "^X-Face:" "^X-Mail-Count:" "^X-ML-COUNT:"
          )))

;; $B1#$A$9%a$B!<$A%k%X%C%@$rV86(!#(B
(setq wl-message-ignored-field-list
      (append mime-view-ignored-field-list
      '(".*Received:" ".*Path:" ".*Id:" "^References:"
        "^Replied:" "^Errors-To:"
        "^Lines:" "^Sender:" ".*Host:" "^Xref:"
        "^Content-Type:" "^Content-Transfer-Encoding:"
        "^Precedence:"
        "^Status:" "^X-VM-.*:"
        "^X-Info:" "^X-PGP" "^X-Face-Version:"
        "^X-UIDL:" "^X-Dispatcher:"
        "^MIME-Version:" "^X-ML" "^Message-I.:"
        "^Delivered-To:" "^Mailing-List:"
        "^ML-Name:" "^Reply-To:" "Date:"
        "^X-Loop" "^X-List-Help:"
        "^X-Trace:" "^X-Complaints-To:"
        "^Received-SPF:" "^Message-ID:"
        "^MIME-Version:" "^Content-Transfer-Encoding:"
        "^Authentication-Results:"
        "^X-Priority:" "^X-MSMail-Priority:"
        "^X-Mailer:" "^X-MimeOLE:"
        )))


;;;---------------------------------------------------
;; $A%U%!%$%kC{$,HU1>$B8l$A$NLm86%U%!%$%k$r%G%3$B!<$A%I$9$k(B [semi-gnus-ja: 4332]
(eval-after-load "mime"
'(defadvice mime-entity-filename
(after eword-decode-for-broken-MUA activate)
"Decode eworded file name for *BROKEN* MUA."
(when (stringp ad-return-value)
(setq ad-return-value (eword-decode-string ad-return-value t)))))

;; $A%U%!%$%kC{$,HU1>$B8l$A$NLm86%U%!%$%k$r%(%s%3$B!<$A%I$9$k(B [semi-gnus-ja: 6046]
(eval-after-load "std11"
  '(defadvice std11-wrap-as-quoted-string (before encode-string activate)
     "Encode a string."
     (require 'eword-encode)
     (ad-set-arg 0 (or (eword-encode-string (ad-get-arg 0)) "" )) ))


;; $ALm86%U%!%$%k$,$"$k$B>l$A:O$O!8(B@$A!9$r1mJ>(B
(setq elmo-msgdb-extra-fields
(cons "content-type" elmo-msgdb-extra-fields))
(setq wl-summary-line-format-spec-alist
(append wl-summary-line-format-spec-alist
'((?@ (wl-summary-line-attached)))))
(setq wl-summary-line-format "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")
