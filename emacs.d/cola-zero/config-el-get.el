;; install el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (with-current-buffer (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

;; add emacsmirror-rcp toel-get-recipe-path
;; https://github.com/edenc/emacsmirror-rcp.git
(add-to-list 'el-get-recipe-path (expand-file-name "~/.emacs.d/cola-zero/active-recipes"))

(el-get 'sync)

;; システムのレシピを上書きできる
;; システムに入ってないレシピも記述する
(setq el-get-sources
      '((:name sass-mode
               :description "Major mode for editing Sass files"
               :type git
               :url "https://github.com/nex3/sass-mode.git"
               :features sass-mode
               :depends haml-mode
               :post-init (lambda ()
                            (add-to-list 'auto-mode-alist
                                         '("\\.scss$" . sass-mode))))
        (:name yasnippet
               :website "https://github.com/capitaomorte/yasnippet"
               :description "YASnippet is a template system for Emacs."
               :type git
               :url "https://github.com/capitaomorte/yasnippet.git"
               :features "yasnippet"
               :prepare (lambda ()
                          ;; Set up the default snippets directory
                          ;;
                          ;; Principle: don't override any user settings
                          ;; for yas/snippet-dirs, whether those were made
                          ;; with setq or customize.  If the user doesn't
                          ;; want the default snippets, she shouldn't get
                          ;; them!
                          (unless (or (boundp 'yas/snippet-dirs) (get 'yas/snippet-dirs 'customized-value))
                            (setq yas/snippet-dirs
                                  (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets")))))
               :post-init (lambda ()
                            ;; Trick customize into believing the standard
                            ;; value includes the default snippets.
                            ;; yasnippet would probably do this itself,
                            ;; except that it doesn't include an
                            ;; installation procedure that sets up the
                            ;; snippets directory, and thus doesn't know
                            ;; where those snippets will be installed.  See
                            ;; http://code.google.com/p/yasnippet/issues/detail?id=179
                            (put 'yas/snippet-dirs 'standard-value
                                 ;; as cus-edit.el specifies, "a cons-cell
                                 ;; whose car evaluates to the standard
                                 ;; value"
                                 (list (list 'quote
                                             (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets"))))))
               ;; byte-compile load vc-svn and that fails
               ;; see https://github.com/dimitri/el-get/issues/200
               :compile nil)
        (:name yasnippets-rails
               :description "yasnippets-rails"
               :depends yasnippet
               :type git
               :url "https://github.com/eschulte/yasnippets-rails.git"
               :complile nil)
	;; (:name slime
	;;        :description "Superior Lisp Interaction Mode for Emacs"
	;;        :type git
	;;        :module "slime"
	;;        :info "doc"
	;;        :url "https://github.com/nablaone/slime.git"
	;;        :load-path ("." "contrib")
	;;        :compile (".")
	;;        :build ("make -C doc")
	;;        :build/darwin ("PATH="
	;;        )

	)
      )



;; 自分用パッケージリストの初期化
;; 設定ファイル名とレシピ名が一致するものは自動でパッケージリストに追加
(setq
 my-el-get-packages
 (remove-if-not '(lambda (pkg)
                   (el-get-recipe-filename pkg))
                my-emacs-misc-config))

;; 設定ファイル名とレシピ名が一致しないものは自分で追加
;; (mapcar '(lambda (elem)
;;            (add-to-list 'my-el-get-packages elem))
;;         '(ruby-electric
;;           sass-mode
;;           yasnippets-rails
;;           japanese-holidays
;;           grep-edit))

(el-get-emacswiki-refresh (concat my-emacs-config-dir "/../el-get/el-get/recipes/emacswiki"))
(el-get 'sync my-el-get-packages)
