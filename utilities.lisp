(in-package :cl-ncurses)
;;below from Paul Graham book
(defun tokens (str test start)
  (let ((p1 (position-if test str :start start)))
    (if p1
        (let ((p2 (position-if #'(lambda (c)
                                   (not (funcall test c)))
                               str :start p1)))
          (cons (subseq str p1 p2)
                (if p2
                    (tokens str test p2)
                  nil)))
      nil)))

(defun str-exclude (x)

  (or (eq #\SPACE x)
      (eq #\" x)
      (eq #\, x)))

(defun str-tokenize (string)

(let ((nospc (lambda (x) (not (str-exclude x)))))
  (tokens string nospc 0)))