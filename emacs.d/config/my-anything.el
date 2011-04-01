;;; Anything
(setq warning-suppress-types nil)
(setq anything-command-map-prefix-key "C-c C-<SPC>")
(package-install 'repo.or.cz '((files . ("anything-config"))
                               (additional-paths . ("extensions")))
                 'anything-startup)
(require 'anything-startup)
(define-key global-map (kbd "C-x b") 'anything-filelist+)
(define-key global-map (kbd "C-x C-f") 'anything-filelist+)
(global-set-key (kbd "C-M-y") 'anything-show-kill-ring)
(if (eq system-type 'darwin)
    (progn
      (setq anything-c-filelist-file-name "/tmp/mnt/all.filelist")
      (setq anything-grep-candidates-fast-directory-regexp "^/tmp\/mnt"))
  (progn
    (setq anything-c-filelist-file-name "/tmp/all.filelist")
    (setq anything-grep-candidates-fast-directory-regexp "^/tmp")))
(add-to-list 'anything-c-source-buffers '(migemo))
;; anything-hatena-bookmark
(package-install 'github "k1LoW/anything-hatena-bookmark" 'anything-hatena-bookmark)
(global-set-key (kbd "C-c C-b") 'anything-hatena-bookmark)
(setq anything-hatena-bookmark-samewindow t)
;; descbinds-anything.el
(package-install 'emacswiki "descbinds-anything.el" 'descbinds-anything)
(descbinds-anything-install)
;; anything-mac-itunes
;; http://d.hatena.ne.jp/yaotti/20101202/1291295796
(when (eq system-type 'darwin)
  (progn
    (package-install 'gist "725271" 'anything-mac-itunes)
    (global-set-key (kbd "C-c i m") 'anything-mac-itunes)
    (global-set-key (kbd "C-c i b") 'anything-mac-itunes-back-track)
    (global-set-key (kbd "C-c i n") 'anything-mac-itunes-next-track)
    (global-set-key (kbd "C-c i p") 'anything-mac-itunes-playpause-track)
    (global-set-key (kbd "C-c i C") 'anything-mac-itunes-show-current-track-info)))
;; anything-c-moccur
(package-install 'coderepos "anything-c-moccur" 'anything-c-moccur)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする
;;; キーバインドの割当(好みに合わせて設定してください)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))

;; anything-project.el
;; https://github.com/imakado/anything-project.git
(package-install 'github "imakado/anything-project" 'anything-project)
(global-set-key (kbd "C-c C-f") 'anything-project)
 
