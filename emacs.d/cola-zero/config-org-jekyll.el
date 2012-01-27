(require 'org-publish)
(require 'org-jekyll)
(setq org-publish-blog "~/work/blog.mkoga.net/source")
(add-to-list 'org-publish-project-alist
             `("my-posts"
               :base-directory "~/work/blog.mkoga.net/org"
               :recursive t
               :base-extension "org"
               :publishing-directory ,org-publish-blog
               :blog-publishing-directory ,org-publish-blog
               :site-root "http://blog.mkoga.net"
               :jekyll-sanitize-permalinks t
               :publishing-function org-publish-org-to-html
               :section-numbers nil
               :headline-levels 4
               :table-of-contents t
               :auto-index nil
               :auto-preamble nil
               :body-only t
               :auto-postamble nil))

(provide 'config-org-jekyll)
