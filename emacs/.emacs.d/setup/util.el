(provide 'util)
(require 'dash)

;; --------------------
;; Util

(defun extend-mode-map (mode-map &rest table)
  (declare (indent defun))
  (--> table
       (-partition 2 it)
       (-each it (lambda (stroke)
		   (define-key mode-map
		     (kbd (car stroke)) (cadr stroke))))))

(defun lorem-ipsum ()
  (interactive)
  (insert "\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\""))
