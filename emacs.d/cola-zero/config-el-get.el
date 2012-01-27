;; install el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (with-current-buffer (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

;; add emacsmirror-rcp toel-get-recipe-path
;; https://github.com/edenc/emacsmirror-rcp.git
(add-to-list 'el-get-recipe-path (expand-file-name "~/.emacs.d/cola-zero/active-recipes"))

(el-get-emacswiki-refresh (expand-file-name "~/.emacs.d/el-get/el-get/recipes/emacswiki"))

(setq my-el-get-packages
      '("auto-complete"
        "calfw"
        "auto-async-byte-compile"
        "apel"
        "deferred"
        "e2wm"
        "window-layout"
        "emacs-w3m"
        "id-manager"
        "nognus"
        "org-mode"
        "org-jekyll"
        "po-mode"
        "ri-emacs"
        "rsense"
        "windows"
        "rvm" ;; https://github.com/senny/rvm.el/issues/18
        "autotest"
        ))
(el-get 'sync my-el-get-packages)


(provide 'config-el-get)
