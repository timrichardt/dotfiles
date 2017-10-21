;; init.el

(require 'package)
(package-initialize)
(require 'dash)

;; --------------------
;; Disable menu, scroll bar, tool bar, cursor blinking

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode '(2 . 0))
(blink-cursor-mode -1)

;; --------------------
;; Initial appearance

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
;; Package repositories

(defvar repos
  '(("melpa" . "https://melpa.org/packages/")
    ("org" . "http://orgmode.org/elpa/")))

(defun add-repo
    (repo)
  (add-to-list 'package-archives repo t))

(-each repos 'add-repo)

;; --------------------
;; Configurations

(defvar setups
  '("global"
    "lisp"
    "rust"
    "secretary"))

(defun load-setup
    (setup)
  (require (intern setup)))

(add-to-list 'load-path (expand-file-name "setup" user-emacs-directory))
(add-to-list 'exec-path "/home/tim/bin")

(-each setups 'load-setup)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(aggressive-indent
     smex
     inf-clojure
     weather-metno
     ido-yes-or-no
     ido-at-point
     flx-ido
     ido-ubiquitous
     ido-vertical-mode
     undo-tree
     subatomic-theme
     rainbow-delimiters
     org-agenda-property
     magit
     dash-functional
     clj-refactor
     alect-themes)))

;; Mitigate Bug#28350 (security) in Emacs 25.2 and earlier.
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))
