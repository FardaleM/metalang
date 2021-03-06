#lang racket
(require racket/block)

(define (triangle n)
  (if (eq? (remainder n 2) 0)
  (* (quotient n 2) (+ n 1))
  (* n (quotient (+ n 1) 2)))
)

(define (penta n)
  (if (eq? (remainder n 2) 0)
  (* (quotient n 2) (- (* 3 n) 1))
  (* (quotient (- (* 3 n) 1) 2) n))
)

(define (hexa n)
  (* n (- (* 2 n) 1))
)

(define (findPenta2 n a b)
  (if (eq? b (+ a 1))
  (or (eq? (penta a) n) (eq? (penta b) n))
  (let ([c (quotient (+ a b) 2)])
  (let ([p (penta c)])
  (if (eq? p n)
  #t
  (if (< p n)
  (findPenta2 n c b)
  (findPenta2 n a c))))))
)

(define (findHexa2 n a b)
  (if (eq? b (+ a 1))
  (or (eq? (hexa a) n) (eq? (hexa b) n))
  (let ([c (quotient (+ a b) 2)])
  (let ([p (hexa c)])
  (if (eq? p n)
  #t
  (if (< p n)
  (findHexa2 n c b)
  (findHexa2 n a c))))))
)

(define main
  (letrec ([d (lambda (n) (if (<= n 55385)
                          (let ([t0 (triangle n)])
                          (if (and (findPenta2 t0 (quotient n 5) n) (findHexa2 t0 (quotient n 5) (+ (quotient n 2) 10)))
                          (block
                            (printf "~a\n~a\n" n t0)
                            (d (+ n 1))
                            )
                          (d (+ n 1))))
                          '()))])
    (d 285))
)

