;;-*- mode:Emacs-Lisp -*-
;;; フォント設定処理を.emacsから抜粋したもの。

;;; IME-patch作者さんのページよりで
;;; (http://homepage3.nifty.com/y3tk/emacs.html)
(setq w32-use-w32-font-dialog nil)

(setq scalable-fonts-allowed t)
(setq w32-enable-synthesized-fonts t)

;;; フォントセット作成関数
;;; http://homepage.mac.com/matsuan_tamachan/emacs/ntemacs_font.el.txtより
(defvar ntemacs-font-defined-sizes '(7 8 9 10 12 14 16 18 20 24))

(defun ntemacs-font-create-fontset
  (fontset ascii-font latin1-font gb-font big5-font japanese-font korean-font def-font size-list)
  (let (size)
    (while size-list
      (setq size (car size-list))
      (setq size-list (cdr size-list))
      (create-fontset-from-ascii-font
       (format "-outline-%s-normal-r-normal-normal-%d-*-*-*-*-*-iso8859-1"
			   ascii-font size)
       nil
       (format "%s%02d" fontset size))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'latin-iso8859-1
						(cons latin1-font "iso8859*"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'japanese-jisx0208
						(cons japanese-font "jisx0208-sjis"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'katakana-jisx0201
						(cons japanese-font "jisx0201-katakana"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'chinese-gb2312
						(cons gb-font "gb2312"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'chinese-big5-1
						(cons big5-font "big5"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'korean-ksc5601
						(cons korean-font "ksc5601.1987"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'thai-tis620
						(cons def-font "tis620"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'mule-unicode-0100-24ff
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'latin-iso8859-3
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'cyrillic-iso8859-5
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'greek-iso8859-7
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'vietnamese-viscii-lower
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'vietnamese-viscii-upper
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'tibetan
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'lao
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'ipa
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'arabic-1-column
						(cons def-font "*-#178"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'arabic-2-column
						(cons def-font "*-#178"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						'ethiopic
						(cons def-font "iso10646-1"))
      (set-fontset-font (format "fontset-%s%02d" fontset size)
						`(,(decode-char 'ucs #x2800) . ,(decode-char 'ucs #x28ff))
						'("Barille*" . "iso10646-1")))))

;;; 使えるフォントは以下のS式を評価して判断
;;; (insert (prin1-to-string (x-list-fonts "*")))

;;; IPAゴシックを登録
(ntemacs-font-create-fontset
 "IPA" "IPAゴシック" "Lucida Console*" "Arial Unicode MS*"
 "Arial Unicode MS*" "IPAゴシック*" "Arial Unicode MS*"
 "Arial Unicode MS*"
 ntemacs-font-defined-sizes)

;; ;;; asciiにAnonymousフォントを使用
;; (ntemacs-font-create-fontset
;;  "AnonIPA" "Anonymous" "Anonymous*" "Arial Unicode MS*"
;;  "Arial Unicode MS*" "IPAゴシック*" "Arial Unicode MS*"
;;  "Tahoma*"
;;  ntemacs-font-defined-sizes)

;; VL Gothic VL ゴシック
(ntemacs-font-create-fontset
 "VLGothic" "VL ゴシック" "Lucida Console*" "Arial Unicode MS*"
 "Arial Unicode MS*" "VL ゴシック*" "Arial Unicode MS*"
 "Arial Unicode MS*"
 ntemacs-font-defined-sizes)

;;; デフォルトフォントの設定
;; (add-to-list 'default-frame-alist
;; 	     '(font . "fontset-IPA14"))
;; (add-to-list 'default-frame-alist
;; 	     '(font . "fontset-AnonIPA12"))
(add-to-list 'default-frame-alist
			 '(font . "fontset-VLGothic12"))


;;; 日本語フォントをやや大きめに
;;フォントサイズによって日本語フォントの表示サイズを調整する必要あり。
;;フォントサイズ14だと1.3あたりがちょうどよかった。
(add-to-list 'face-font-rescale-alist
			 `(,(encode-coding-string ".*VLゴシック.*normal.*jisx*" 'emacs-mule) . 1.4))
(add-to-list 'face-font-rescale-alist
			 `(,(encode-coding-string ".*VLゴシック.*bold.*jisx*" 'emacs-mule) . 1.3))
(add-to-list 'face-font-rescale-alist
			 `(,(encode-coding-string ".*VLゴシック.*italic.*jisx*" 'emacs-mule) . 1.3))
(add-to-list 'face-font-rescale-alist
			 '(".*Anonymous.*bold.*" . 0.9))
(add-to-list 'face-font-rescale-alist
			 '(".*Anonymous.*italic.*" . 0.9))


(set-face-attribute 'default nil
                    :family "ＶＬ ゴシック"
                    :height 120)

(set-fontset-font "fontset-default"
                  'japanese-jisx0208
                  '("ＶＬ ゴシック*" . "jisx0208-sjis"))

(set-fontset-font "fontset-default"
                  'katakana-jisx0201
                  '("ＶＬ ゴシック*" . "jisx0201-katakana"))

(setq w32-enable-synthesized-fonts t)

(add-to-list 'face-font-rescale-alist
             `(,(encode-coding-string ".*ＶＬ.*bold.*iso8859.*" 'emacs-mule) . 0.9))

(add-to-list 'face-font-rescale-alist
             `(,(encode-coding-string ".*ＶＬ.*bold.*jisx02.*" 'emacs-mule) . 0.95))
