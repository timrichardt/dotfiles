;;; common --- Overall settings
;;; Commentary:
;;; Code:

(use-package all-the-icons)

(use-package all-the-icons-ivy
  :requires (all-the-icons ivy)
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package all-the-icons-dired
  :requires (all-the-icons)
  :hook (all-the-icons-dired-mode . dired-mode))

(use-package all-the-icons-ibuffer
  :requires (all-the-icons))

(set-face-attribute 'default nil :font "SauceCodePro Nerd Font" :height 92)

(use-package simple-modeline
  :hook (after-init . simple-modeline-mode))

(use-package ivy
  :hook (after-init . ivy-mode))

(setq backup-directory-alist         `((".*" . "~/.saves/"))
      auto-save-file-name-transforms `((".*"   "~/.saves/" t))
      custom-file                    (expand-file-name "customs.el" user-emacs-directory))

(use-package magit)

(defun join-next-line
    ()
	"Kill after cursor and append next line."
  (interactive)
  (join-line -1))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window)))

(use-package writeroom-mode)

(global-set-key (kbd "<f12>")   'tabak-toggle)
(global-set-key (kbd "M-j")     'join-next-line)
(global-set-key (kbd "C-M-+")   'text-scale-increase)
(global-set-key (kbd "C-M--")   'text-scale-decrease)
(global-set-key (kbd "C-M-0")   'text-scale-default)
(global-set-key (kbd "<f2>")    'comment-region)
(global-set-key (kbd "C-<f2>")  'uncomment-region)
(global-set-key (kbd "<f8>")    'highlight-symbol)
(global-set-key (kbd "<f1>")    'ibuffer)

(setq-default tab-width 2)

(provide 'common)

;;; common.el ends here
