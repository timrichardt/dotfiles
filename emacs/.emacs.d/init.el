;;; init.el

;; --------------------
;; disable menu, scroll bar, tool bar, cursor blinking

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode '(2 . 0))
(blink-cursor-mode -1)

;; --------------------
;; start buffer

(setq inhibit-startup-message t)

(setq initial-scratch-message
      (mapconcat
       'identity
       (append
	(mapcar
	 (lambda (x) (concat ";; " x))
	 (butlast (split-string (concat "
       ,           , 
      /             \\ 
     ((__-^^-,-^^-__)) 
      `- ---' `--- -' 
       `--|o` 'o|--' 
          \\  `  / 
           ): :( 
           :o_o: 
            \"-\" 

" (shell-command-to-string "fortune -a")) "\n"))) '("" "")) "\n"))

;; --------------------
;; ensure use-package is installed from MELPA

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (unless package-archive-contents (package-refresh-contents))
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; --------------------
;; globally used packages, settings, functions, ...

(use-package common
  :load-path "conf/")

(use-package lisps
  :load-path "conf/")

(use-package rust
  :load-path "conf/")

(use-package lsp
  :load-path "conf/")

(use-package tabak-theme
  :load-path "conf/"
  :commands (tabak-theme-dark)
  :init (tabak-theme-dark)
  :bind (("<f12>" . tabak-theme-toggle)))
