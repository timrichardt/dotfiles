;;; conf/lsp.el

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
				 (clojure-mode . lsp)
         (svelte-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
	:custom ((lsp-clojure-server-command '("java" "-jar" "/home/tim/src/app/clj-kondo-lsp-server-standalone.jar")))
  :config (progn
						(dolist (m '(clojure-mode
												 clojurescript-mode))
							(add-to-list 'lsp-language-id-configuration `(,m . "clojure")))
						(add-to-list 'lsp-language-id-configuration '(svelte-mode . "svelte")))
  :commands lsp)

(use-package lsp-ui ;;  :commands lsp-ui-mode
	)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language


(use-package treemacs-magit
  :after (treemacs magit))

(use-package which-key
  :config
  (which-key-mode))

(use-package svelte-mode
	:config ())

(use-package prettier-js
	:hook svelte-mode)

(use-package flycheck
	:pin melpa
  :init (global-flycheck-mode))

(provide 'lsp)
;;; lsp.el ends here
