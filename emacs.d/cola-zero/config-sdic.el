(when (require 'sdic nil t)
  (global-set-key "\C-cw" 'sdic-describe-word)
  (setq sdic-eiwa-dictionary-list
        '((sdicf-client "/usr/share/dict/eijirou.sdic")
          (sdicf-client "/usr/share/dict/gene.sdic")
          (sdicf-client "/usr/share/dict/eedict.sdic")))
  (setq sdic-waei-dictionary-list
        '((sdicf-client "/usr/share/dict/waeijirou.sdic")
          (sdicf-client "/usr/share/dict/jgene.sdic")
          (sdicf-client "/usr/share/dict/jedict.sdic"))))

(provide 'config-sdic)
