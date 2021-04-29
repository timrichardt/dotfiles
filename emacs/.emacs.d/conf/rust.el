;;; conf/rust.el

(provide 'rust)

;; > rustup default stable
;; > cargo install racer

;; Add rust src:
;; > rustup component add rust-src

;; Change to nightly toolchain
;; > rustup default nightly

;; Change to stable toolchain
;; > rustup default stable

(use-package racer
  :init (setq rust-rustfmt-bin "/home/tim/bin/rustfmt-wrapper")
  :hook ((rust-mode) . racer-mode)
  :bind (("C-M-ö" . 'rust-format-buffer)
	 ("M-,"   . 'racer-find-definition)))
