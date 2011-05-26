;; .wl

;; 標準メーラとして使用する
(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
	(setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
	(define-mail-user-agent
	  'wl-user-agent
	  'wl-user-agent-compose
	  'wl-draft-send
	  'wl-draft-kill
	  'mail-send-hook))

;; IMAP サーバの設定
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "colazero@mail.mkoga.net") ; メールアドレス
(setq elmo-imap4-default-authenticate-type 'clear)
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)
(setq elmo-imap4-use-modified-utf7 t) ; 日本語フォルダ対策

;; SMTP サーバの設定
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "colazero@mail.mkoga.net") ; 適宜修正
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "gmail.com")

;; 一意なmessage-ID 動的IPアドレスの場合に設定。何か適当な文字列を。例えばメールアドレスとか。
(setq wl-from "Masahiro Koga <colazero@mail.mkoga.net>")

;;;------------------------------------------
;;; その他の設定
;; デフォルトのフォルダ
(setq wl-default-folder "%inbox")
;; フォルダ名補完時に使用するデフォルトのスペック
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAPの仕様に合わせて
(setq wl-trash-folder "%[Gmail]/Trash")
;; 下書きディレクトリをローカルに設定する.
(setq wl-draft-folder "+Drafts")
(setq wl-folder-check-async t) ; 非同期でチェックするように
;; 大きなメッセージを分割して送信しない(デフォルトはtで分割する)
(setq mime-edit-split-message nil)
;; 起動時からオフラインにする
;; (setq wl-plugged nil)
;; サマリモードで日時を英語表示
;; (setq wl-summary-weekday-name-lang 'en)
;; HTMLファイルは表示しない。
; (setq mime-setup-enable-inline-html nil)
;; メールを書くときは見出し画面を残して、フル画面にする
(setq wl-draft-reply-buffer-style 'keep)
;; 送信済みIMAPフォルダは送信と同時に既読にする
(setq wl-fcc-force-as-read t)
;; 最初からスレッドを開いておかない
(setq wl-thread-insert-opened nil)
;; スレッドを分割するしきい値(デフォルト：30)
(setq wl-summary-max-thread-depth 30)
;; 警告無しに開けるメールサイズの最大値(デフォルト：30K)
(setq elmo-message-fetch-threshold 500000)
;; プリフェッチ時に確認を求めるメールサイズの最大値(デフォルト：30K)
(setq wl-prefetch-threshold 500000)

;;;------------------------------------------
(setq wl-dispose-folder-alist
      (cons '("^%inbox" . remove) wl-dispose-folder-alist))


;;;------------------------------------------
;;; from,to のデコード指定。
(mime-set-field-decoder
 'From nil 'eword-decode-and-unfold-unstructured-field-body)
(mime-set-field-decoder
 'To nil 'eword-decode-and-unfold-unstructured-field-body)

;;;------------------------------------------
;; summary-mode ですべての header を一旦除去
(setq mime-view-ignored-field-list '("^.*"))

;; 表示するヘッダ。
(setq wl-message-visible-field-list
      (append mime-view-visible-field-list
        '("^Subject:" "^From:" "^To:" "^Cc:"
          "^X-Mailer:" "^X-Newsreader:" "^User-Agent:"
          "^X-Face:" "^X-Mail-Count:" "^X-ML-COUNT:"
          )))

;; 隠すメールヘッダを指定。
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
;; ファイル名が日本語の添付ファイルをデコードする [semi-gnus-ja: 4332]
(eval-after-load "mime"
'(defadvice mime-entity-filename
(after eword-decode-for-broken-MUA activate)
"Decode eworded file name for *BROKEN* MUA."
(when (stringp ad-return-value)
(setq ad-return-value (eword-decode-string ad-return-value t)))))

;; ファイル名が日本語の添付ファイルをエンコードする [semi-gnus-ja: 6046]
(eval-after-load "std11"
  '(defadvice std11-wrap-as-quoted-string (before encode-string activate)
     "Encode a string."
     (require 'eword-encode)
     (ad-set-arg 0 (or (eword-encode-string (ad-get-arg 0)) "" )) ))


;; 添付ファイルがある場合は「@」を表示
(setq elmo-msgdb-extra-fields
(cons "content-type" elmo-msgdb-extra-fields))
(setq wl-summary-line-format-spec-alist
(append wl-summary-line-format-spec-alist
'((?@ (wl-summary-line-attached)))))
(setq wl-summary-line-format "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")

;;w3mを使用する
(require 'mime-w3m)

;; プリフェッチの設定
; プリフェッチを有効にするフォルダ
(setq wl-message-buffer-prefetch-folder-type-list '(imap4))
; プリフェッチのサイズ制限. nil なら無限大
(setq wl-message-buffer-prefetch-threshold nil)

;; browse url key
;; http://www.emacswiki.org/emacs/WanderLust
(add-hook 'mime-view-mode-hook
	  (lambda ()
	    (local-set-key "f" 'browse-url)))

;; デフォルトのフォルダ
(setq wl-default-folder "%inbox")

;; フォルダ名補完時に使用するデフォルトのスペック
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAPの仕様に合わせて
(setq wl-trash-folder "%[Gmail]/Trash")

(setq wl-folder-check-async t) ; 非同期でチェックするように

(setq wl-dispose-folder-alist
      (cons '("^%inbox" . remove) wl-dispose-folder-alist))

;; browse url key
;; http://www.emacswiki.org/emacs/WanderLust
;; (add-hook 'mime-view-mode-hook
;; 	  (lambda ()
;; 	    (local-set-key <return> 'w3m-view-url-with-external-browser)))

(setq smtp-end-of-line "\n")
