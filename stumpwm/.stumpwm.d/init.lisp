;; -*-lisp-*-
;;
;; Here is a sample .stumpwmrc file

(require :swank)

(require :stumpwm)

(in-package :stumpwm)

(swank-loader:init)

(swank:create-server :port 5556
                     :style swank:*communication-style*
                     :dont-close t)

(stumpwm:stumpwm)

(set-prefix-key (kbd "C-t"))
