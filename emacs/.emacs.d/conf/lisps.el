;;; conf/lisps.el

(provide 'lisps)


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


(defun eval-last-sexp-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
	     (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))


(use-package paredit
  :hook ((emacs-lisp-mode lisp-mode clojure-mode) . paredit-mode)
  :bind (:map
	 paredit-mode-map
	 ("C-f"         . 'forward-sexp)
	 ("C-b"         . 'backward-sexp)
	 ("C-t"         . 'transpose-sexps-forward-or-backward)
	 ("<C-right>"   . 'forward-word)
	 ("<C-left>"    . 'backward-word)
	 ("<M-right>"   . 'paredit-forward-slurp-sexp)
	 ("<M-left>"    . 'paredit-forward-barf-sexp)
	 ("<C-M-right>" . 'paredit-backward-barf-sexp)
	 ("<C-M-left>"  . 'paredit-backward-slurp-sexp)
	 ("<M-up>"      . 'paredit-raise-sexp)
	 ("<C-M-up>"    . 'paredit-splice-sexp-killing-backward)
	 ("<M-down>"    . 'paredit-split-sexp)
	 :map
	 emacs-lisp-mode-map
	 ("C-c C-e" . 'eval-last-sexp-and-replace )))


(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode lisp-mode clojure-mode) . rainbow-delimiters-mode))


(use-package aggressive-indent
  :hook ((emacs-lisp-mode lisp-mode clojure-mode) . aggressive-indent-mode))


(setq show-paren-delay 0.0
      show-paren-style 'expression)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(use-package slime)
