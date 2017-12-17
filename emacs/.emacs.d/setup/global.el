(provide 'global)
(require 'util)
(require 'ido)
(require 'flx-ido)
(require 'ido-completing-read+)
(require 'ido-vertical-mode)
(require 'ido-at-point)
(require 'ido-yes-or-no)
(require 'tabak-theme)
(require 'smex)
(require 'highlight-symbol)
(require 'exec-path-from-shell)

(extend-mode-map (current-global-map)
  "<f12>"   'tabak-toggle
  "M-j"     'join-next-line
  "M-x"     'smex
  "C-M-+"   'text-scale-increase
  "C-M--"   'text-scale-decrease
  "C-M-0"   'text-scale-default
  "<f2>"    'comment-region
  "C-<f2>"  'uncomment-region
  "<f8>"    'highlight-symbol
  "<f1>"    'ibuffer)

;; --------------------
;; Movement

(defun join-next-line
    ()
  (interactive)
  (join-line -1))

;; --------------------
;; Look

(set-face-attribute 'default nil :font "Source Code Pro")

(defun text-scale-default ()
  "Reset the text scale to the default scaling 0."
  (interactive)
  (text-scale-set 0))

(add-hook 'post-command-hook 'set-cursor-type-according-to-mode)

(defun set-cursor-type-according-to-mode ()
  "Set cursor type according to the current buffers
minor mode."
  (setq cursor-type (cond
		     (buffer-read-only
		      'hbar)

		     (overwrite-mode
		      'box)

		     (t
		      'bar))))

;; --------------------
;; Auto Save

(setq backup-directory-alist         `((".*" . "~/.saves/"))
      auto-save-file-name-transforms `((".*"   "~/.saves/" t))
      custom-file                    (expand-file-name "customs.el" user-emacs-directory))

;; --------------------
;; Ido

(setq ido-enable-prefix                      nil
      ido-enable-flex-matching               nil
      ido-case-fold                          nil
      ido-use-faces                          nil
      ido-auto-merge-work-directories-length -1
      ido-create-new-buffer                  'always
      ido-use-filename-at-point              nil
      ido-max-prospects                      10
      ido-confirm-unique-completion          t
      ido-vertical-define-keys               'C-n-C-p-up-down-left-right)

(ido-mode 1)
(ido-vertical-mode 1)
(flx-ido-mode 1)
(ido-at-point-mode 1)
(ido-ubiquitous-mode 1)
(ido-yes-or-no-mode 1)


;; --------------------
;; Use external SSH agent

(exec-path-from-shell-copy-env "SSH_AGENT_PID")
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
