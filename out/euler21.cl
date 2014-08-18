
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))(defun remainder (a b) (- a (* b (truncate a b))))
(defun eratostene (t_ max_)
(progn
  (let ((n 0))
    (do
      ((i 2 (+ 1 i)))
      ((> i (- max_ 1)))
      (if
        (= (aref t_ i) i)
        (progn
          (setq n ( + n 1))
          (let ((j (* i i)))
            (loop while (and (< j max_) (> j 0))
            do (progn
                 (setf (aref t_ j) 0)
                 (setq j ( + j i))
                 )
            )
          )))
    )
    (return-from eratostene n)
  )))

(defun fillPrimesFactors (t_ n primes nprimes)
(progn
  (do
    ((i 0 (+ 1 i)))
    ((> i (- nprimes 1)))
    (progn
      (let ((d (aref primes i)))
        (loop while (= (remainder n d) 0)
        do (progn
             (setf (aref t_ d) (+ (aref t_ d) 1))
             (setq n ( quotient n d))
             )
        )
        (if
          (= n 1)
          (return-from fillPrimesFactors (aref primes i)))
      ))
  )
  (return-from fillPrimesFactors n)
))

(defun sumdivaux2 (t_ n i)
(progn
  (loop while (and (< i n) (= (aref t_ i) 0))
  do (setq i ( + i 1))
  )
  (return-from sumdivaux2 i)
))

(defun sumdivaux (t_ n i)
(if
  (> i n)
  (return-from sumdivaux 1)
  (if
    (= (aref t_ i) 0)
    (return-from sumdivaux (sumdivaux t_ n (sumdivaux2 t_ n (+ i 1))))
    (progn
      (let ((o (sumdivaux t_ n (sumdivaux2 t_ n (+ i 1)))))
        (let ((out_ 0))
          (let ((p i))
            (do
              ((j 1 (+ 1 j)))
              ((> j (aref t_ i)))
              (progn
                (setq out_ ( + out_ p))
                (setq p ( * p i))
              )
            )
            (return-from sumdivaux (* (+ out_ 1) o))
          )))))))

(defun sumdiv (nprimes primes n)
(progn
  (let ((a (+ n 1)))
    (let
     ((t_ (array_init
             a
             (function (lambda (i)
             (block lambda_1
               (return-from lambda_1 0)
             ))
             ))))
    (let ((max_ (fillPrimesFactors t_ n primes nprimes)))
      (return-from sumdiv (sumdivaux t_ max_ 0))
    )))))

(progn
  (let ((maximumprimes 1001))
    (let
     ((era (array_init
              maximumprimes
              (function (lambda (j)
              (block lambda_2
                (return-from lambda_2 j)
              ))
              ))))
    (let ((nprimes (eratostene era maximumprimes)))
      (let
       ((primes (array_init
                   nprimes
                   (function (lambda (o)
                   (block lambda_3
                     (return-from lambda_3 0)
                   ))
                   ))))
      (let ((l 0))
        (do
          ((k 2 (+ 1 k)))
          ((> k (- maximumprimes 1)))
          (if
            (= (aref era k) k)
            (progn
              (setf (aref primes l) k)
              (setq l ( + l 1))
            ))
        )
        (princ l)
        (princ " == ")
        (princ nprimes)
        (princ "
")
        (let ((sum 0))
          (do
            ((n 2 (+ 1 n)))
            ((> n 1000))
            (progn
              (let ((other (- (sumdiv nprimes primes n) n)))
                (if
                  (> other n)
                  (progn
                    (let ((othersum (- (sumdiv nprimes primes other) other)))
                      (if
                        (= othersum n)
                        (progn
                          (princ other)
                          (princ " & ")
                          (princ n)
                          (princ "
")
                          (setq sum ( + sum (+ other n)))
                        ))
                    )))
              ))
          )
          (princ "
")
          (princ sum)
          (princ "
")
        )))))))


