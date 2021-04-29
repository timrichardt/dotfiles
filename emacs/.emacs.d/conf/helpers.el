;;; helpers.el

(provide 'helpers)

(defun extend-mode-map (mode-map &rest table)
  (declare (indent defun))
  (--> table
       (-partition 2 it)
       (-each it (lambda (stroke)
		   (define-key mode-map
		     (kbd (car stroke)) (cadr stroke))))))
