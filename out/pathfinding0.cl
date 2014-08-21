
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))
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

(defun min2 (a b)
(if
  (< a b)
  (return-from min2 a)
  (return-from min2 b)))

(defun read_char_matrix (x y)
(progn
  (let
   ((tab (array_init
            y
            (function (lambda (z)
            (block lambda_1
              (let
               ((h (array_init
                      x
                      (function (lambda (k)
                      (block lambda_2
                        (let ((l (mread-char )))
                          (return-from lambda_2 l)
                        )))
                      ))))
              (mread-blank)
              (let ((g h))
                (return-from lambda_1 g)
              ))))
            ))))
  (return-from read_char_matrix tab)
  )))

(defun pathfind_aux (cache tab x y posX posY)
(if
  (and (= posX (- x 1)) (= posY (- y 1)))
  (return-from pathfind_aux 0)
  (if
    (or (or (or (< posX 0) (< posY 0)) (>= posX x)) (>= posY y))
    (return-from pathfind_aux (* (* x y) 10))
    (if
      (eq (aref (aref tab posY) posX) (int-char 35))
      (return-from pathfind_aux (* (* x y) 10))
      (if
        (not (= (aref (aref cache posY) posX) (- 0 1)))
        (return-from pathfind_aux (aref (aref cache posY) posX))
        (progn
          (setf (aref (aref cache posY) posX) (* (* x y) 10))
          (let ((val1 (pathfind_aux cache tab x y (+ posX 1) posY)))
            (let ((val2 (pathfind_aux cache tab x y (- posX 1) posY)))
              (let ((val3 (pathfind_aux cache tab x y posX (- posY 1))))
                (let ((val4 (pathfind_aux cache tab x y posX (+ posY 1))))
                  (let ((o (min2 val1 val2)))
                    (let ((p (min2 (min2 o val3) val4)))
                      (let ((m p))
                        (let ((out_ (+ 1 m)))
                          (setf (aref (aref cache posY) posX) out_)
                          (return-from pathfind_aux out_)
                        ))))))))))))))

(defun pathfind (tab x y)
(progn
  (let
   ((cache (array_init
              y
              (function (lambda (i)
              (block lambda_3
                (let
                 ((tmp (array_init
                          x
                          (function (lambda (j)
                          (block lambda_4
                            (princ (aref (aref tab i) j))
                            (return-from lambda_4 (- 0 1))
                          ))
                          ))))
                (princ "
")
                (return-from lambda_3 tmp)
                )))
              ))))
  (return-from pathfind (pathfind_aux cache tab x y 0 0))
  )))

(progn
  (let ((r (mread-int )))
    (mread-blank)
    (let ((q r))
      (let ((x q))
        (let ((u (mread-int )))
          (mread-blank)
          (let ((s u))
            (let ((y s))
              (princ x)
              (princ " ")
              (princ y)
              (princ "
")
              (let ((tab (read_char_matrix x y)))
                (let ((result (pathfind tab x y)))
                  (princ result)
                )))))))))


