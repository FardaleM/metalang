
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))
(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (while (and last-char (>= (char-int last-char) (char-int #\0)) (<= (char-int last-char) (char-int #\9)))
        (progn
          (setq out (+ (* 10 out) (- (char-int last-char) (char-int #\0))))
          (next-char)
        )
      )
      out
    ))))
(defun mread-blank () (progn
  (while (or (eq last-char #\NewLine) (eq last-char #\Space) ) (next-char))
))

(defun read_int ()
(progn
  (let ((out_ (mread-int )))
    (mread-blank)
    (return-from read_int out_)
  )))

(defun read_int_line (n)
(progn
  (let
   ((tab (array_init
            n
            (function (lambda (i)
            (block lambda_1
              (let ((t_ (mread-int )))
                (mread-blank)
                (return-from lambda_1 t_)
              )))
            ))))
  (return-from read_int_line tab)
  )))

(defun read_int_matrix (x y)
(progn
  (let
   ((tab (array_init
            y
            (function (lambda (z)
            (block lambda_2
              (let
               ((b (array_init
                      x
                      (function (lambda (c)
                      (block lambda_3
                        (let ((d (mread-int )))
                          (mread-blank)
                          (return-from lambda_3 d)
                        )))
                      ))))
              (let ((a b))
                (return-from lambda_2 a)
              ))))
            ))))
  (return-from read_int_matrix tab)
  )))

(defun programme_candidat (tableau x y)
(progn
  (let ((out_ 0))
    (do
      ((i 0 (+ 1 i)))
      ((> i (- y 1)))
      (do
        ((j 0 (+ 1 j)))
        ((> j (- x 1)))
        (setq out_ ( + out_ (* (aref (aref tableau i) j) (+ (* i 2) j))))
        )
    )
    (return-from programme_candidat out_)
  )))

(progn
  (let ((f (mread-int )))
    (mread-blank)
    (let ((e f))
      (let ((taille_x e))
        (let ((h (mread-int )))
          (mread-blank)
          (let ((g h))
            (let ((taille_y g))
              (let ((tableau (read_int_matrix taille_x taille_y)))
                (princ (programme_candidat tableau taille_x taille_y))
                (princ "
")
              ))))))))

