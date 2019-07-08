;; -*-lisp-*-
;;
;; Here is a sample .stumpwmrc file

(in-package :stumpwm)

(require :swank)

(swank-loader:init)

(swank:create-server :port 4004
                     :style swank:*communication-style*
                     :dont-close t)

(define-key *top-map* (kbd "H-TAB") "fnext")
(define-key *top-map* (kbd "H-j") "pull-hidden-next")
(define-key *top-map* (kbd "H-k") "pull-hidden-previous")

(set-prefix-key (kbd "H-a"))

;; (toggle-mode-line (current-screen) (current-head))

(setf *transient-border-width* 0
      *maxsize-border-width*   0
      *normal-border-width*    0
      *window-border-style*    :none
      *mouse-focus-policy*     :sloppy)

;; (sync-all-frame-windows (current-group))

;; (run-shell-command "compton -i 0.8")

;; (sb-ext:run-program "polybar" '("bar" "--reload"))

;; Update polybar group indicator
(add-hook *post-command-hook*
	  (lambda (command)
	    (when (member command '(stumpwm:gnext
				    stumpwm:gnext-with-window
				    stumpwm:gprev
				    stumpwm:gprev-with-window
				    stumpwm:gother
				    stumpwm:gkill
				    stumpwm:gselect
				    stumpwm:gmove-and-follow
				    stumpwm:gnew
				    stumpwm:gnew-float
				    stumpwm:emacs))
	      (run-shell-command "polybar-msg hook stumpwmgroups 1"))))

(sb-ext:run-program "/usr/bin/xmodmap" '("/home/tim/.Xmodmap"))

;; (sb-thread:make-thread
;;  (lambda ()
;;    (dotimes (n 30)
;;      (sleep 0.5)
;;      (sb-ext:run-program "/usr/bin/xmodmap" '("/home/tim/.Xmodmap")))))
