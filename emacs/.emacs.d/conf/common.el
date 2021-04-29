;;; conf/common.el

(provide 'common)

(use-package all-the-icons)

(use-package all-the-icons-ivy
  :requires (all-the-icons ivy)
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package all-the-icons-dired
  :requires (all-the-icons)
  :hook (all-the-icons-dired-mode . dired-mode))

(use-package all-the-icons-ibuffer
  :requires (all-the-icons))

(set-face-attribute 'default nil :font "SauceCodePro Nerd Font" :height 87)

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
  (interactive)
  (join-line -1))

;; (extend-mode-map (current-global-map)
;;   "<f12>"   'tabak-toggle
;;   "M-j"     'join-next-line
;;   ;; "M-x"     'smex
;;   "C-M-+"   'text-scale-increase
;;   "C-M--"   'text-scale-decrease
;;   "C-M-0"   'text-scale-default
;;   "<f2>"    'comment-region
;;   "C-<f2>"  'uncomment-region
;;   "<f8>"    'highlight-symbol
;;   "<f1>"    'ibuffer)
