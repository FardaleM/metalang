
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))(defun remainder (a b) (- a (* b (truncate a b))))(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))
(defun mread-blank () (progn
  (while (or (eq last-char #\NewLine) (eq last-char #\Space) ) (next-char))
))

(defun max2 (a b)
(if
  (> a b)
  (return-from max2 a)
  (return-from max2 b)))

(defun min2 (a b)
(if
  (< a b)
  (return-from min2 a)
  (return-from min2 b)))

(defstruct (bigint (:type list) :named)
  bigint_sign
  bigint_len
  bigint_chiffres
  )

(defun read_bigint (len)
(progn
  (let
   ((chiffres (array_init
                 len
                 (function (lambda (j)
                 (block lambda_1
                   (let ((c (mread-char )))
                     (return-from lambda_1 (char-int c))
                   )))
                 ))))
  (do
    ((i 0 (+ 1 i)))
    ((> i (quotient (- len 1) 2)))
    (progn
      (let ((tmp (aref chiffres i)))
        (setf (aref chiffres i) (aref chiffres (- (- len 1) i)))
        (setf (aref chiffres (- (- len 1) i)) tmp)
      ))
  )
  (let ((o (make-bigint :bigint_sign t
                        :bigint_len len
                        :bigint_chiffres chiffres)))
  (return-from read_bigint o)
  ))))

(defun print_bigint (a)
(progn
  (if
    (not (bigint-bigint_sign a))
    (princ (int-char 45)))
  (do
    ((i 0 (+ 1 i)))
    ((> i (- (bigint-bigint_len a) 1)))
    (princ
    (aref (bigint-bigint_chiffres a) (- (- (bigint-bigint_len a) 1) i)))
  )
))

(defun bigint_eq (a b)
(progn
  #| Renvoie vrai si a = b |#
  (if
    (not (eq (bigint-bigint_sign a) (bigint-bigint_sign b)))
    (return-from bigint_eq nil)
    (if
      (not (= (bigint-bigint_len a) (bigint-bigint_len b)))
      (return-from bigint_eq nil)
      (progn
        (do
          ((i 0 (+ 1 i)))
          ((> i (- (bigint-bigint_len a) 1)))
          (if
            (not (= (aref (bigint-bigint_chiffres a) i) (aref (bigint-bigint_chiffres b) i)))
            (return-from bigint_eq nil))
        )
        (return-from bigint_eq t)
      )))
))

(defun bigint_gt (a b)
(progn
  #| Renvoie vrai si a > b |#
  (if
    (and (bigint-bigint_sign a) (not (bigint-bigint_sign b)))
    (return-from bigint_gt t)
    (if
      (and (not (bigint-bigint_sign a)) (bigint-bigint_sign b))
      (return-from bigint_gt nil)
      (progn
        (if
          (> (bigint-bigint_len a) (bigint-bigint_len b))
          (return-from bigint_gt (bigint-bigint_sign a))
          (if
            (< (bigint-bigint_len a) (bigint-bigint_len b))
            (return-from bigint_gt (not (bigint-bigint_sign a)))
            (do
              ((i 0 (+ 1 i)))
              ((> i (- (bigint-bigint_len a) 1)))
              (progn
                (let ((j (- (- (bigint-bigint_len a) 1) i)))
                  (if
                    (> (aref (bigint-bigint_chiffres a) j) (aref (bigint-bigint_chiffres b) j))
                    (return-from bigint_gt (bigint-bigint_sign a))
                    (if
                      (< (aref (bigint-bigint_chiffres a) j) (aref (bigint-bigint_chiffres b) j))
                      (return-from bigint_gt (not (bigint-bigint_sign a)))))
                ))
              )))
        (return-from bigint_gt t)
      )))
))

(defun bigint_lt (a b)
(return-from bigint_lt (not (bigint_gt a b))))

(defun add_bigint_positif (a b)
(progn
  #| Une addition ou on en a rien a faire des signes |#
  (let ((len (+ (max2 (bigint-bigint_len a) (bigint-bigint_len b)) 1)))
    (let ((retenue 0))
      (let
       ((chiffres (array_init
                     len
                     (function (lambda (i)
                     (block lambda_2
                       (let ((tmp retenue))
                         (if
                           (< i (bigint-bigint_len a))
                           (setq tmp ( + tmp (aref (bigint-bigint_chiffres a) i))))
                         (if
                           (< i (bigint-bigint_len b))
                           (setq tmp ( + tmp (aref (bigint-bigint_chiffres b) i))))
                         (setq retenue (quotient tmp 10))
                         (return-from lambda_2 (remainder tmp 10))
                       )))
                     ))))
      (loop while (and (> len 0) (= (aref chiffres (- len 1)) 0))
      do (setq len ( - len 1))
      )
      (let ((p (make-bigint :bigint_sign t
                            :bigint_len len
                            :bigint_chiffres chiffres)))
      (return-from add_bigint_positif p)
      ))))))

(defun sub_bigint_positif (a b)
(progn
  #| Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
|#
  (let ((len (bigint-bigint_len a)))
    (let ((retenue 0))
      (let
       ((chiffres (array_init
                     len
                     (function (lambda (i)
                     (block lambda_3
                       (let ((tmp (+ retenue (aref (bigint-bigint_chiffres a) i))))
                         (if
                           (< i (bigint-bigint_len b))
                           (setq tmp ( - tmp (aref (bigint-bigint_chiffres b) i))))
                         (if
                           (< tmp 0)
                           (progn
                             (setq tmp ( + tmp 10))
                             (setq retenue (- 0 1))
                           )
                           (setq retenue 0))
                         (return-from lambda_3 tmp)
                       )))
                     ))))
      (loop while (and (> len 0) (= (aref chiffres (- len 1)) 0))
      do (setq len ( - len 1))
      )
      (let ((q (make-bigint :bigint_sign t
                            :bigint_len len
                            :bigint_chiffres chiffres)))
      (return-from sub_bigint_positif q)
      ))))))

(defun neg_bigint (a)
(progn
  (let ((r (make-bigint :bigint_sign (not (bigint-bigint_sign a))
                        :bigint_len (bigint-bigint_len a)
                        :bigint_chiffres (bigint-bigint_chiffres a))))
  (return-from neg_bigint r)
)))

(defun add_bigint (a b)
(if
  (eq (bigint-bigint_sign a) (bigint-bigint_sign b))
  (if
    (bigint-bigint_sign a)
    (return-from add_bigint (add_bigint_positif a b))
    (return-from add_bigint (neg_bigint (add_bigint_positif a b))))
  (if
    (bigint-bigint_sign a)
    (progn
      #| a positif, b negatif |#
      (if
        (bigint_gt a (neg_bigint b))
        (return-from add_bigint (sub_bigint_positif a b))
        (return-from add_bigint (neg_bigint (sub_bigint_positif b a))))
    )
    (progn
      #| a negatif, b positif |#
      (if
        (bigint_gt (neg_bigint a) b)
        (return-from add_bigint (neg_bigint (sub_bigint_positif a b)))
        (return-from add_bigint (sub_bigint_positif b a)))
    ))))

(defun sub_bigint (a b)
(return-from sub_bigint (add_bigint a (neg_bigint b))))

(defun mul_bigint_cp (a b)
(progn
  #| Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. |#
  (let ((len (+ (+ (bigint-bigint_len a) (bigint-bigint_len b)) 1)))
    (let
     ((chiffres (array_init
                   len
                   (function (lambda (k)
                   (block lambda_4
                     (return-from lambda_4 0)
                   ))
                   ))))
    (do
      ((i 0 (+ 1 i)))
      ((> i (- (bigint-bigint_len a) 1)))
      (progn
        (let ((retenue 0))
          (do
            ((j 0 (+ 1 j)))
            ((> j (- (bigint-bigint_len b) 1)))
            (progn
              (setf (aref chiffres (+ i j)) (+ (aref chiffres (+ i j)) (+ retenue (* (aref (bigint-bigint_chiffres b) j) (aref (bigint-bigint_chiffres a) i)))))
              (setq retenue (quotient (aref chiffres (+ i j)) 10))
              (setf (aref chiffres (+ i j)) (remainder (aref chiffres (+ i j)) 10))
            )
          )
          (setf (aref chiffres (+ i (bigint-bigint_len b))) (+ (aref chiffres (+ i (bigint-bigint_len b))) retenue))
        ))
    )
    (setf (aref chiffres (+ (bigint-bigint_len a) (bigint-bigint_len b))) (quotient (aref chiffres (- (+ (bigint-bigint_len a) (bigint-bigint_len b)) 1)) 10))
    (setf (aref chiffres (- (+ (bigint-bigint_len a) (bigint-bigint_len b)) 1)) (remainder (aref chiffres (- (+ (bigint-bigint_len a) (bigint-bigint_len b)) 1)) 10))
    (do
      ((l 0 (+ 1 l)))
      ((> l 2))
      (if
        (and (not (= len 0)) (= (aref chiffres (- len 1)) 0))
        (setq len ( - len 1)))
    )
    (let ((s (make-bigint :bigint_sign (eq (bigint-bigint_sign a) (bigint-bigint_sign b))
                          :bigint_len len
                          :bigint_chiffres chiffres)))
    (return-from mul_bigint_cp s)
    )))))

(defun bigint_premiers_chiffres (a i)
(progn
  (let ((len (min2 i (bigint-bigint_len a))))
    (loop while (and (not (= len 0)) (= (aref (bigint-bigint_chiffres a) (- len 1)) 0))
    do (setq len ( - len 1))
    )
    (let ((u (make-bigint :bigint_sign (bigint-bigint_sign a)
                          :bigint_len len
                          :bigint_chiffres (bigint-bigint_chiffres a))))
    (return-from bigint_premiers_chiffres u)
  ))))

(defun bigint_shift (a i)
(progn
  (let ((e (+ (bigint-bigint_len a) i)))
    (let
     ((chiffres (array_init
                   e
                   (function (lambda (k)
                   (block lambda_5
                     (if
                       (>= k i)
                       (return-from lambda_5 (aref (bigint-bigint_chiffres a) (- k i)))
                       (return-from lambda_5 0))
                   ))
                   ))))
    (let ((v (make-bigint :bigint_sign (bigint-bigint_sign a)
                          :bigint_len (+ (bigint-bigint_len a) i)
                          :bigint_chiffres chiffres)))
    (return-from bigint_shift v)
    )))))

(defun mul_bigint (aa bb)
(if
  (= (bigint-bigint_len aa) 0)
  (return-from mul_bigint aa)
  (if
    (= (bigint-bigint_len bb) 0)
    (return-from mul_bigint bb)
    (if
      (or (< (bigint-bigint_len aa) 3) (< (bigint-bigint_len bb) 3))
      (return-from mul_bigint (mul_bigint_cp aa bb))
      (progn
        #| Algorithme de Karatsuba |#
        (let ((split (quotient (min2 (bigint-bigint_len aa) (bigint-bigint_len bb)) 2)))
          (let ((a (bigint_shift aa (- 0 split))))
            (let ((b (bigint_premiers_chiffres aa split)))
              (let ((c (bigint_shift bb (- 0 split))))
                (let ((d (bigint_premiers_chiffres bb split)))
                  (let ((amoinsb (sub_bigint a b)))
                    (let ((cmoinsd (sub_bigint c d)))
                      (let ((ac (mul_bigint a c)))
                        (let ((bd (mul_bigint b d)))
                          (let ((amoinsbcmoinsd (mul_bigint amoinsb cmoinsd)))
                            (let ((acdec (bigint_shift ac (* 2 split))))
                              (return-from mul_bigint (add_bigint (add_bigint acdec bd) (bigint_shift (sub_bigint (add_bigint ac bd) amoinsbcmoinsd) split)))
                              #| ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd |#
                            ))))))))))))))))

#|
Division,
Modulo
|#
(defun log10 (a)
(progn
  (let ((out_ 1))
    (loop while (>= a 10)
    do (progn
         (setq a ( quotient a 10))
         (setq out_ ( + out_ 1))
         )
    )
    (return-from log10 out_)
  )))

(defun bigint_of_int (i)
(progn
  (let ((size (log10 i)))
    (if
      (= i 0)
      (setq size 0))
    (let
     ((t_ (array_init
             size
             (function (lambda (j)
             (block lambda_6
               (return-from lambda_6 0)
             ))
             ))))
    (do
      ((k 0 (+ 1 k)))
      ((> k (- size 1)))
      (progn
        (setf (aref t_ k) (remainder i 10))
        (setq i ( quotient i 10))
      )
    )
    (let ((w (make-bigint :bigint_sign t
                          :bigint_len size
                          :bigint_chiffres t_)))
    (return-from bigint_of_int w)
    )))))

(defun fact_bigint (a)
(progn
  (let ((one (bigint_of_int 1)))
    (let ((out_ one))
      (loop while (not (bigint_eq a one))
      do (progn
           (setq out_ (mul_bigint a out_))
           (setq a (sub_bigint a one))
           )
      )
      (return-from fact_bigint out_)
    ))))

(defun sum_chiffres_bigint (a)
(progn
  (let ((out_ 0))
    (do
      ((i 0 (+ 1 i)))
      ((> i (- (bigint-bigint_len a) 1)))
      (setq out_ ( + out_ (aref (bigint-bigint_chiffres a) i)))
    )
    (return-from sum_chiffres_bigint out_)
  )))

#| http://projecteuler.net/problem=20 |#
(defun euler20 ()
(progn
  (let ((a (bigint_of_int 15)))
    #| normalement c'est 100 |#
    (setq a (fact_bigint a))
    (return-from euler20 (sum_chiffres_bigint a))
  )))

(defun bigint_exp (a b)
(if
  (= b 1)
  (return-from bigint_exp a)
  (if
    (= (remainder b 2) 0)
    (return-from bigint_exp (bigint_exp (mul_bigint a a) (quotient b 2)))
    (return-from bigint_exp (mul_bigint a (bigint_exp a (- b 1)))))))

(defun bigint_exp_10chiffres (a b)
(progn
  (setq a (bigint_premiers_chiffres a 10))
  (if
    (= b 1)
    (return-from bigint_exp_10chiffres a)
    (if
      (= (remainder b 2) 0)
      (return-from bigint_exp_10chiffres (bigint_exp_10chiffres (mul_bigint a a) (quotient b 2)))
      (return-from bigint_exp_10chiffres (mul_bigint a (bigint_exp_10chiffres a (- b 1))))))
))

(defun euler48 ()
(progn
  (let ((sum (bigint_of_int 0)))
    (do
      ((i 1 (+ 1 i)))
      ((> i 100))
      (progn
        #| 1000 normalement |#
        (let ((ib (bigint_of_int i)))
          (let ((ibeib (bigint_exp_10chiffres ib i)))
            (setq sum (add_bigint sum ibeib))
            (setq sum (bigint_premiers_chiffres sum 10))
          )))
    )
    (princ "euler 48 = ")
    (print_bigint sum)
    (princ "
")
  )))

(defun euler16 ()
(progn
  (let ((a (bigint_of_int 2)))
    (setq a (bigint_exp a 100))
    #| 1000 normalement |#
    (return-from euler16 (sum_chiffres_bigint a))
  )))

(defun euler25 ()
(progn
  (let ((i 2))
    (let ((a (bigint_of_int 1)))
      (let ((b (bigint_of_int 1)))
        (loop while (< (bigint-bigint_len b) 100)
        do (progn
             #| 1000 normalement |#
             (let ((c (add_bigint a b)))
               (setq a b)
               (setq b c)
               (setq i ( + i 1))
             ))
        )
        (return-from euler25 i)
      )))))

(defun euler29 ()
(progn
  (let ((maxA 5))
    (let ((maxB 5))
      (let ((f (+ maxA 1)))
        (let
         ((a_bigint (array_init
                       f
                       (function (lambda (j)
                       (block lambda_7
                         (return-from lambda_7 (bigint_of_int (* j j)))
                       ))
                       ))))
        (let ((g (+ maxA 1)))
          (let
           ((a0_bigint (array_init
                          g
                          (function (lambda (j2)
                          (block lambda_8
                            (return-from lambda_8 (bigint_of_int j2))
                          ))
                          ))))
          (let ((h (+ maxA 1)))
            (let
             ((b (array_init
                    h
                    (function (lambda (k)
                    (block lambda_9
                      (return-from lambda_9 2)
                    ))
                    ))))
            (let ((n 0))
              (let ((found t))
                (loop while found
                do (progn
                     (let ((min_ (aref a0_bigint 0)))
                       (setq found nil)
                       (do
                         ((i 2 (+ 1 i)))
                         ((> i maxA))
                         (if
                           (<= (aref b i) maxB)
                           (if
                             found
                             (if
                               (bigint_lt (aref a_bigint i) min_)
                               (setq min_ (aref a_bigint i)))
                             (progn
                               (setq min_ (aref a_bigint i))
                               (setq found t)
                             )))
                       )
                       (if
                         found
                         (progn
                           (setq n ( + n 1))
                           (do
                             ((l 2 (+ 1 l)))
                             ((> l maxA))
                             (if
                               (and (bigint_eq (aref a_bigint l) min_) (<= (aref b l) maxB))
                               (progn
                                 (setf (aref b l) (+ (aref b l) 1))
                                 (setf (aref a_bigint l) (mul_bigint (aref a_bigint l) (aref a0_bigint l)))
                               ))
                           )
                         ))
                     ))
                )
                (return-from euler29 n)
              ))))))))))))

(progn
  (princ (euler29 ))
  (princ "
")
  (let ((sum (read_bigint 50)))
    (do
      ((i 2 (+ 1 i)))
      ((> i 100))
      (progn
        (mread-blank)
        (let ((tmp (read_bigint 50)))
          (setq sum (add_bigint sum tmp))
        ))
    )
    (princ "euler13 = ")
    (print_bigint sum)
    (princ "
")
    (princ "euler25 = ")
    (princ (euler25 ))
    (princ "
")
    (princ "euler16 = ")
    (princ (euler16 ))
    (princ "
")
    (euler48 )
    (princ "euler20 = ")
    (princ (euler20 ))
    (princ "
")
    (let ((a (bigint_of_int 999999)))
      (let ((b (bigint_of_int 9951263)))
        (print_bigint a)
        (princ ">>1=")
        (print_bigint (bigint_shift a (- 0 1)))
        (princ "
")
        (print_bigint a)
        (princ "*")
        (print_bigint b)
        (princ "=")
        (print_bigint (mul_bigint a b))
        (princ "
")
        (print_bigint a)
        (princ "*")
        (print_bigint b)
        (princ "=")
        (print_bigint (mul_bigint_cp a b))
        (princ "
")
        (print_bigint a)
        (princ "+")
        (print_bigint b)
        (princ "=")
        (print_bigint (add_bigint a b))
        (princ "
")
        (print_bigint b)
        (princ "-")
        (print_bigint a)
        (princ "=")
        (print_bigint (sub_bigint b a))
        (princ "
")
        (print_bigint a)
        (princ "-")
        (print_bigint b)
        (princ "=")
        (print_bigint (sub_bigint a b))
        (princ "
")
        (print_bigint a)
        (princ ">")
        (print_bigint b)
        (princ "=")
        (let ((m (bigint_gt a b)))
          (if
            m
            (princ "True")
            (princ "False"))
          (princ "
")
        )))))


