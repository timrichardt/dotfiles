(provide 'lisp)
(require 'util)
(require 'paredit)
(require 'aggressive-indent)
(require 'slime-autoloads)
(require 'clojure-mode)
(require 'inf-clojure)
(require 'cider)
(require 'cl)
(require 'clj-refactor)
(require 'auto-complete)
(require 'ac-cider)

(extend-mode-map paredit-mode-map
  "C-f"         'forward-sexp
  "C-b"         'backward-sexp
  "C-t"         'transpose-sexps-forward-or-backward
  "<C-right>"   'forward-word
  "<C-left>"    'backward-word
  "<M-right>"   'paredit-forward-slurp-sexp
  "<M-left>"    'paredit-forward-barf-sexp
  "<C-M-right>" 'paredit-backward-barf-sexp
  "<C-M-left>"  'paredit-backward-slurp-sexp
  "<M-up>"      'paredit-raise-sexp
  "<C-M-up>"    'paredit-splice-sexp-killing-backward
  "<M-down>"    'paredit-split-sexp)

;; --------------------
;; General

(setq show-paren-delay 0.0
      show-paren-style 'expression)

(defun transpose-sexps-forward-or-backward ()
  "If POINT is at the beginning of a collection or symbol,
transposes the collection or symbol upwards. If POINT is at
the end of a collection or symbol, transposes the collection
or symbol downwards. If POINT is inside a symbol or the
collection or symbol is at an extreme position, returns nil."
  (interactive)
  (cond
   ((and (looking-at "\\s(\\|\\_<\\|\\\"\\|'\\|`\\|~\\|@")
	 (not (looking-back "\\s(")))
    (transpose-sexps 1)
    (backward-sexp 2))

   ((and (looking-back "\\s)\\|\\_>\\|\\\"")
	 (not (looking-at "\\s)")))
    (transpose-sexps 1))))

;; --------------------
;; Elisp

(defun eval-last-sexp-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(add-hook 'emacs-lisp-mode-hook (lambda ()
				  (aggressive-indent-mode)
				  (enable-paredit-mode)
				  (rainbow-delimiters-mode)
				  (show-paren-mode)))


;; --------------------
;; Common Lisp

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq inferior-lisp-program "/usr/bin/sbcl")

(add-to-list 'slime-contribs 'slime-fancy)

(add-hook 'slime-mode-hook (lambda ()
			     (aggressive-indent-mode)
			     (enable-paredit-mode)
			     (rainbow-delimiters-mode)
			     (show-paren-mode)))

(add-hook 'slime-repl-mode-hook (lambda ()
				  (enable-paredit-mode)))

;; --------------------
;; Clojure

(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(setq cider-prompt-for-symbol        nil
      cider-repl-use-pretty-printing t
      cider-repl-history-file        "~/.cider-repl-history"
      cider-cljs-lein-repl           "(do (require 'figwheel-sidecar.repl-api)
                                         (figwheel-sidecar.repl-api/start-figwheel!)
                                         (figwheel-sidecar.repl-api/cljs-repl))"
      inf-clojure-program            "lumo -d")

(add-hook 'clojure-mode-hook
	  (lambda ()
	    (aggressive-indent-mode)
	    (enable-paredit-mode)
	    (rainbow-delimiters-mode)
	    (show-paren-mode)
	    (clj-refactor-mode 1)
	    (cljr-add-keybindings-with-prefix "C-c C-m")))

(add-hook 'cider-mode-hook
	  (lambda ()
	    (auto-complete-mode)
	    (ac-flyspell-workaround)
	    (ac-cider-setup)))

(add-hook 'cider-repl-mode-hook
	  (lambda ()
	    (enable-paredit-mode)
	    (rainbow-delimiters-mode)
	    (auto-complete-mode)
	    (ac-cider-setup)))

(put 'define-component 'clojure-backtracking-indent '(4 4 (2)))
