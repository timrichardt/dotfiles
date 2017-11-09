(provide 'rust)
(require 'racer)

(extend-mode-map rust-mode-map
  "C-M-ö" 'rust-format-buffer)

;; > rustup default stable
;; > cargo install racer

;; Add rust src:
;; > rustup component add rust-src

;; Change to nightly toolchain
;; > rustup default nightly

;; Change to stable toolchain
;; > rustup default stable

(setq rust-rustfmt-bin "/home/tim/bin/rustfmt-wrapper")

(add-hook 'rust-mode-hook 'racer-mode)
