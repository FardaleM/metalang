#lang racket
(require racket/block)
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-int (lambda ()
  (if (eq? #\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\0)) (<= (char->integer last-char) (char->integer #\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))

(struct intlist ([head #:mutable] [tail #:mutable]))

(define (cons0 list i)
  (intlist i list)
)

(define (is_empty foo)
  #t
)

(define (rev2 acc torev)
  (if (is_empty torev)
  acc
  (let ([acc2 (intlist (intlist-head torev) acc)])
  (rev2 acc (intlist-tail torev))))
)

(define (rev empty torev)
  (rev2 empty torev)
)

(define (test empty)
  (let ([list empty])
  (let ([i (- 1)])
  (letrec ([a (lambda (i list) (if (not (eq? i 0))
                               ((lambda (b) 
                                  (let ([i b])
                                  (if (not (eq? i 0))
                                  (let ([list (cons0 list i)])
                                  (a i list))
                                  (a i list)))) (mread-int))
    '()))])
  (a i list))))
)

(define main
  '()
)

