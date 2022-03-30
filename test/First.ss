(import (only (chezscheme) record-case))

(define (A) (begin (display "encountered axiom: A\n") (exit 1)))

(define (id) (lambda (a) (force a)))

(define (true) (list 'true))

(define (false) (list 'false))

(define (not) (lambda (a) (record-case (force a) ((true) () (false))
((false) () (true)))))

(define 
  (ite)
  (lambda 
    (a)
    (lambda 
      (b)
      (lambda (c) (lambda (d) (record-case (force b) ((true) () (force c))
((false) () (force d))))))))

(define (loop) (loop))

(define (test1) (((((ite) (delay (list))) (delay (false))) (delay (loop))) (delay (true))))

(define (zero) (list 'zero))

(define (suc) (lambda (a) (list 'suc a)))

(define (one) ((suc) (delay (zero))))

(define (two) ((suc) (delay (one))))

(define (three) ((suc) (delay (two))))

(define (pred) (lambda (a) (record-case (force a) ((zero) () (force a))
((suc) (b) (force b)))))

(define 
  (plus)
  (lambda 
    (a)
    (lambda 
      (b)
      (record-case 
        (force a)
        ((zero) () (force b))
        ((suc) (c) ((suc) (delay (((plus) (delay (force c))) (delay (force b))))))))))

(define 
  (twice)
  (lambda 
    (a)
    (record-case 
      (force a)
      ((zero) () (force a))
      ((suc) (b) ((suc) (delay ((suc) (delay ((twice) (delay (force b)))))))))))

(define 
  (pow2)
  (lambda 
    (a)
    (record-case 
      (force a)
      ((zero) () ((suc) (delay (force a))))
      ((suc) (b) ((twice) (delay ((pow2) (delay (force b)))))))))

(define 
  (consume)
  (lambda (a) (record-case (force a) ((zero) () (force a))
((suc) (b) ((consume) (delay (force b)))))))

(define (test2) ((consume) (delay ((pow2) (delay ((twice) (delay ((twice) (delay ((twice) (delay (three))))))))))))

(define (nil) (list 'nil))

(define (con) (lambda (a) (lambda (b) (lambda (c) (list 'con a
b
c)))))

(define (head) (lambda (a) (lambda (b) (lambda (c) (record-case (force c) ((con) (d e f) (force e)))))))

(define (tail) (lambda (a) (lambda (b) (lambda (c) (record-case (force c) ((con) (d e f) (force f)))))))

(define 
  (map)
  (lambda 
    (a)
    (lambda 
      (b)
      (lambda 
        (c)
        (lambda 
          (d)
          (lambda 
            (e)
            (record-case 
              (force e)
              ((nil) () (force e))
              ((con) 
                (f g h)
                ((((con) (delay (force f))) (delay ((force d) (delay (force g))))) 
                  (delay 
                    ((((((map) (delay (list))) (delay (list))) (delay (list))) (delay (force d))) 
                      (delay (force h)))))))))))))

(define 
  (test3)
  ((((head) (delay (list))) (delay (list))) 
    (delay 
      ((((tail) (delay (list))) (delay (list))) 
        (delay 
          ((((((map) (delay (list))) (delay (list))) (delay (list))) (delay (suc))) 
            (delay 
              ((((con) (delay ((suc) (delay ((suc) (delay (zero))))))) (delay (zero))) 
                (delay 
                  ((((con) (delay ((suc) (delay (zero))))) (delay ((suc) (delay (zero))))) 
                    (delay 
                      ((((con) (delay (zero))) (delay ((suc) (delay ((suc) (delay (zero))))))) (delay (nil))))))))))))))